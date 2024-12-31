from data_fetching import fetch_data
from model_loader import load_trained_model
from utils import preprocess_pair
import firebase_admin
from firebase_admin import credentials, firestore
import pandas as pd

def initialize_firebase():
    if not firebase_admin._apps:
        cred = credentials.Certificate(r"E:\Share some key\neww-57221-firebase-adminsdk-4r4jh-cc80fa593b.json")
        firebase_admin.initialize_app(cred)
    db = firestore.client()
    return db

def find_best_match_ai(donations, recipients, model):
    best_matches = {}

    for donation in donations:
        scores = []
        for recipient in recipients:
            features = preprocess_pair(donation, recipient)
            features_df = pd.DataFrame([features])
            proba = model.predict_proba(features_df)

            if proba.shape[1] > 1:
                score = proba[0][1]
            else:
                score = proba[0][0]

            scores.append((score, recipient['user_id']))

        if scores:
            best_match = max(scores, key=lambda x: x[0])
            best_matches[donation['user_id']] = best_match[1]

    return best_matches

def update_matches_in_firebase(matches, db):
    for donation_id, recipient_id in matches.items():
        db.collection('Donation').document(donation_id).update({
            'matched_recipient': recipient_id
        })

if __name__ == "__main__":
    db = initialize_firebase()
    donations, recipients = fetch_data()
    model = load_trained_model()
    matches = find_best_match_ai(donations, recipients, model)
    update_matches_in_firebase(matches, db)
    for donation_id, recipient_id in matches.items():
        print(f"Recipient: {recipient_id} -> Donor: {donation_id}")
