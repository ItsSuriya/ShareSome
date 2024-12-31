import firebase_admin
from firebase_admin import credentials, firestore
import pandas as pd
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.metrics import accuracy_score
from imblearn.over_sampling import SMOTE
import pickle

# Firebase Initialization
def initialize_firebase():
    if not firebase_admin._apps:
        cred = credentials.Certificate(r"E:\Share some key\neww-57221-firebase-adminsdk-4r4jh-cc80fa593b.json")
        firebase_admin.initialize_app(cred)
    return firestore.client()

# Fetch Data from Firebase
def fetch_data(db):
    donations_ref = db.collection('Donation').stream()
    recipients_ref = db.collection('Recipient Request').stream()
    
    donations = []
    recipients = []
    
    for doc in donations_ref:
        donation = doc.to_dict()
        donation['user_id'] = doc.id  # Use document ID as user_id
        donations.append(donation)
        
    for doc in recipients_ref:
        recipient = doc.to_dict()
        recipient['user_id'] = doc.id  # Use document ID as user_id
        recipients.append(recipient)
    
    return donations, recipients

# Preprocess Data
def preprocess_data(donations, recipients):
    data = []
    labels = []

    for donation in donations:
        for recipient in recipients:
            food_type_similarity = 1 if donation.get('food_type') == recipient.get('food_type') else 0
            time_diff = abs(donation.get('time_available', 0) - recipient.get('time_needed', 0))
            quantity_ratio = donation.get('quantity', 1) / recipient.get('quantity', 1)
            
            features = [food_type_similarity, time_diff, quantity_ratio]
            label = 1 if 'matched_donations' in recipient and donation['user_id'] in recipient['matched_donations'] else 0
            data.append(features)
            labels.append(label)
    
    return pd.DataFrame(data, columns=['food_type_similarity', 'time_diff', 'quantity_ratio']), labels

# Train the Model
def train_model(donations, recipients):
    data, labels = preprocess_data(donations, recipients)

    if data.empty or len(labels) == 0:
        print("No data available for training.")
        return None

    # Check label distribution
    print("Label distribution before splitting:")
    print(pd.Series(labels).value_counts())

    X = data[['food_type_similarity', 'time_diff', 'quantity_ratio']]
    y = labels

    # Ensure dataset contains both classes
    if len(set(y)) < 2:
        print("Dataset does not contain at least two classes. Check your preprocessing.")
        return None

    # Oversample the minority class
    smote = SMOTE(random_state=42)
    X, y = smote.fit_resample(X, y)

    # Split data into training and test sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)

    print("Training label distribution:")
    print(pd.Series(y_train).value_counts())
    print("Testing label distribution:")
    print(pd.Series(y_test).value_counts())

    # Advanced model: Gradient Boosting Classifier
    param_grid = {
        'n_estimators': [50, 100, 200],
        'learning_rate': [0.01, 0.1, 0.2],
        'max_depth': [3, 5, 7]
    }
    grid_search = GridSearchCV(GradientBoostingClassifier(random_state=42), param_grid, cv=3, scoring='accuracy')
    grid_search.fit(X_train, y_train)

    model = grid_search.best_estimator_

    # Evaluate the model
    y_pred = model.predict(X_test)
    print("Accuracy:", accuracy_score(y_test, y_pred))

    # Save the trained model
    with open('model.pkl', 'wb') as f:
        pickle.dump(model, f)

    print("Model trained and saved as 'model.pkl'.")
    return model    

# Load Trained Model
def load_trained_model(model_path='model.pkl'):
    try:
        with open(model_path, 'rb') as f:
            return pickle.load(f)
    except FileNotFoundError:
        raise FileNotFoundError(f"Model file not found at {model_path}. Please train the model first.")

# Preprocess Pair for Matching
def preprocess_pair(donor, recipient):
    food_type_similarity = 1 if donor.get('food_type') == recipient.get('food_type') else 0
    time_diff = abs(donor.get('time_available', 0) - recipient.get('time_needed', 0))
    quantity_ratio = donor.get('quantity', 1) / recipient.get('quantity', 1)
    
    return [food_type_similarity, time_diff, quantity_ratio]

# Find Best Matches
def find_best_match_ai(donations, recipients, model):
    best_matches = {}

    for donation in donations:
        scores = []
        for recipient in recipients:
            features = preprocess_pair(donation, recipient)
            proba = model.predict_proba([features])

            if proba.shape[1] > 1:
                score = proba[0][1]  # Probability of a match
            else:
                score = proba[0][0]  # Single probability case

            scores.append((score, recipient['user_id']))

        if scores:
            best_match = max(scores, key=lambda x: x[0])
            best_matches[donation['user_id']] = best_match[1]

    return best_matches

# Update Matches in Firebase
def update_matches_in_firebase(matches, db):
    for donation_id, recipient_id in matches.items():
        db.collection('Donation').document(donation_id).update({
            'matched_recipient': recipient_id
        })

# Main Workflow
if __name__ == "__main__":
    db = initialize_firebase()

    print("Fetching data...")
    donations, recipients = fetch_data(db)

    print("Training the model...")
    model = train_model(donations, recipients)

    if not model:
        model = load_trained_model()

    print("Finding matches...")
    matches = find_best_match_ai(donations, recipients, model)

    print("Updating matches in Firebase...")
    update_matches_in_firebase(matches, db)

    print("Matching complete.")
    print(matches)
