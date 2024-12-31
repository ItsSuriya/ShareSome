def preprocess_pair(donor, recipient):
    features = {
        'food_type_similarity': 1 if donor.get('food_type') == recipient.get('food_type') else 0,
        'time_diff': abs(donor.get('time_available', 0) - recipient.get('time_needed', 0)),
        'quantity_ratio': donor.get('quantity', 1) / recipient.get('quantity', 1)
    }
    return features
