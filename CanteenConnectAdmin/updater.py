from firebase_admin import credentials,firestore
import firebase_admin
import pandas as pd

cred = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

df = []

# food = db.collection("FOOD").get()
# for i in food:
#     menu = db.collection("FOOD").document(i.id).collection("Menu").get()
#     for j in menu:
#         df.append(j.id)
        # db.collection("FOOD").document(i.id).collection("Menu").document(j.id).set({"price":0},merge=True)
    
data = pd.read_csv("items.csv")
print(data)

print("Done")