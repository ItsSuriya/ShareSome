import subprocess

#print("Running model training and matching...")

# Run the model training
subprocess.run(['python', 'model_training.py'], check=True)

# Run the main script for matching and printing the results
subprocess.run(['python', 'main.py'], check=True)
