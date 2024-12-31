import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import joblib
from data_fetching import fetch_data
from data_preparation import preprocess_data

def load_training_data():
    donors, recipients = fetch_data()
    data, labels = preprocess_data(donors, recipients)
    
    #print("Label distribution:", pd.Series(labels).value_counts())
    
    return data, labels

def train_model():
    data, labels = load_training_data()

    if data.empty or len(labels) == 0:
        print("No data available for training.")
        return
    
    X = data
    y = labels

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = RandomForestClassifier(random_state=42)
    model.fit(X_train, y_train)

    y_pred = model.predict(X_test)
    #print("Accuracy:", accuracy_score(y_test, y_pred))

    joblib.dump(model, 'model.joblib')

    #print("Model trained and saved as 'model.joblib'.")

if __name__ == "__main__":
    train_model()
