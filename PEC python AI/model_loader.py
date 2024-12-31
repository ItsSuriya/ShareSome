import joblib

def load_trained_model(model_path='model.joblib'):
    return joblib.load(model_path)
