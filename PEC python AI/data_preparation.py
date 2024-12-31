import pandas as pd
from sklearn.utils import resample
from data_fetching import fetch_data

def preprocess_data(donations, recipients):
    data = []
    labels = []

    for donation in donations:
        for recipient in recipients:
            features = [
                int(donation.get('fooditems', [{}])[0].get('foodType') == recipient.get('Food Type')),
                abs(pd.to_datetime(donation.get('Time', '00:00'), format='%I:%M %p').hour - pd.to_datetime(recipient.get('Prefered time', '00:00'), format='%I:%M %p').hour),
                int(donation.get('fooditems', [{}])[0].get('quantity', 1)) / int(recipient.get('People in need', 1))
            ]
            # Refined matching logic with priority: food type, quantity, time
            label = 1 if features[0] == 1 and features[2] <= 2 and features[1] <= 3 else 0
            data.append(features)
            labels.append(label)

    df = pd.DataFrame(data, columns=['food_type_similarity', 'time_diff', 'quantity_ratio'])
    df['label'] = labels

    # Separate the classes
    df_majority = df[df.label == 0]
    df_minority = df[df.label == 1]

    if len(df_minority) == 0:
        print("No positive class examples. Please add more data.")
        return pd.DataFrame(), []

    # Upsample minority class
    if len(df_majority) > 0 and len(df_minority) > 0:
        df_minority_upsampled = resample(df_minority, replace=True,
                                         n_samples=len(df_majority), random_state=123)

        # Combine majority class with upsampled minority class
        df_upsampled = pd.concat([df_majority, df_minority_upsampled])
        return df_upsampled.drop('label', axis=1), df_upsampled['label']
    else:
        return df.drop('label', axis=1), df['label']
