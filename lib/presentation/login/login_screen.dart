// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    String? emai, pasword;


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  registration() async {
    setState(() {
      emai = email.text;
      pasword = password.text;
    });
    if (emai!=null && pasword!=null){
      if (pasword != null) {
    
        try {
         
          // ignore: unused_local_variable
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: emai.toString(), password: pasword.toString()); 
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    
          sharedPreferences.setString("email", emai.toString());   
          sharedPreferences.setString("password", pasword.toString());   
          
           ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Login Successfully",
              style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,
            ))));
          Navigator.of(context).pushReplacementNamed('/home');      
        }on FirebaseException catch (e) {
         
          if (e.code == 'weak-password') {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color(0XFFEE0000),
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
          } else if (e.code == "email-already-in-use") {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color(0XFFEE0000),
              content: Text(
                "Account Already exsists",
                style: TextStyle(fontSize: 18.0),
              )));
          }
        }
    }}
    else{
      if (emai == null){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color(0XFFEE0000),
              content: Text(
                "Please provide Email",
                style: TextStyle(fontSize: 18.0),)));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color(0XFFEE0000),
              content: Text(
                "Please provide Password",
                style: TextStyle(fontSize: 18.0),)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // ignore: prefer_const_constructors
              Image(image: AssetImage('assets/logo.png'),
              width: double.maxFinite,
              height: sheight/3.64,),


              // SizedBox(height: sheight*(30/sheight)),


              const Text("Login",
              style: TextStyle(
                fontFamily: "Itim",
                fontSize: 50,
                shadows: [Shadow(color: Color(0X3F000000),offset: Offset(0, 3))]
              ),
              textAlign: TextAlign.center,),


              SizedBox(height: sheight*(30/sheight)),

              SizedBox(
                width: swidth/1.24,
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder()
                  ),
                ),
              ),

              SizedBox(height: sheight*(30/sheight)),

              SizedBox(
                width: swidth/1.24,
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder()
                  ),
                ),
              ),


              SizedBox(height: sheight*(50/sheight)),

              SizedBox(
                width: swidth/1.24,
                height: sheight /(sheight/60),
                child: ElevatedButton(onPressed: registration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFEE0000),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Itim",
                    fontSize: 30,
                    shadows: [Shadow(color: Color(0X3F000000),offset: Offset(0, 4))]
                  ),
                )),
              ),
              
              SizedBox(height: sheight*(50/sheight)),


              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                  )),
                  TextButton(onPressed: () {Navigator.of(context).pushReplacementNamed("/signup");},
                    child: const Text("Register",style: TextStyle(
                    fontSize: 20,
                    color: Colors.black)
                  ),)
                ],
              ),


             SizedBox(height: sheight*(50/sheight)),


              TextButton(onPressed: () {Navigator.of(context).pushNamed("/pass_reset");},
               child: const Text("Forget Password?",style: TextStyle(
                    fontSize: 20,
                    color: Colors.black)
                  ))


            ],
          ),
        ),
      );
   
  }
}