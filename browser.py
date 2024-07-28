from pyrebase import initialize_app

firebaseConfig = {
  "apiKey": "AIzaSyDUg2qdrAungywEjwzp1auQdzZt4xazMJM",
  "authDomain": "canteen-connect-85f2a.firebaseapp.com",
  "projectId": "canteen-connect-85f2a",
  "storageBucket": "canteen-connect-85f2a.appspot.com",
  "messagingSenderId": "893219346794",
  "appId": "1:893219346794:web:32fc38e5a7c4c1a966ad13",
  "measurementId": "G-Q05L1T60LN",
  "databaseURL":""
}
firbase = initialize_app(firebaseConfig)
auth = firbase.auth()
    
def signup(email,password):
    
    user = auth.create_user_with_email_and_password(email,password)
    print("done")
    return user

def login(email,password):
        user = auth.sign_in_with_email_and_password(email,password)
        print("login sucessful")
        return user
def google(email):
      user = auth.send_password_reset_email(email)
      print("email sent")
user = login("sannathkoushik@gmail.com","sosa@1025")
print(user)

google("sannathkoushik@gmail.com")
