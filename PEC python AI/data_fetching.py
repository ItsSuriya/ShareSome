import firebase_admin
from firebase_admin import credentials, firestore

def initialize_firebase():
    if not firebase_admin._apps:
        cred = credentials.Certificate(r"E:\Share some key\neww-57221-firebase-adminsdk-4r4jh-cc80fa593b.json")
        firebase_admin.initialize_app(cred)

def fetch_data():
    initialize_firebase()
    db = firestore.client()
    
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
