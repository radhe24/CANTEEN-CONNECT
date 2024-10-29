import "dart:async";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:shared_preferences/shared_preferences.dart";


class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

    String? emai, pasword;


  Future getvalid()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obemail = sharedPreferences.getString("email");
    var obpassword = sharedPreferences.getString("password");

    setState(() {
      emai = obemail;
      pasword = obpassword;
    });
  }
  
  login() async {
       
      if (pasword != null) {
    
        try {
         
          // ignore: unused_local_variable
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: emai.toString(), password: pasword.toString());   
          
           // ignore: use_build_context_synchronously
           ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Login Successfully",
              style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,
            ))));
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacementNamed('/home');      
        }on FirebaseException catch (e) {
         print(e);
        }
      }
  }

@override
void initState() {
  getvalid().whenComplete(() async{
    Timer(const Duration(seconds: 2), () async {
      if(emai!=null){
        await login();
        Navigator.of(context).pushReplacementNamed("/home");
      }
      else{
        Navigator.of(context).pushReplacementNamed("/");
        
      }
    });
  });
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center( 
        child: Lottie.asset("assets/splash.json")
      ),
    );
  }
}