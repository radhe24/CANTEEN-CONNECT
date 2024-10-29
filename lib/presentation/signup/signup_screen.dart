// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:whatsapp/whatsapp.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final accessToken ='EAAH1nlNDohoBO9zX8OksWOUju24UFDAvvMJUbzGihaUHugR0qN18EteNzzZCi50ZCQgWDaLnwoOBB3IcJ2tIhPs4w2GLqWZCVJN3vem1ZC8RWUlGaAUttLr1ZBFO87Jkhp54WhhZATW6mZAWj1YPbXC0OlDT3VZCYrN0QhNtVJZAiwBIYvnBpjoMnGkEsmvCiFcCXZBg57nkx2Sh30ZCEJGcuqfTtBUOjsMHKIRll8V';
  final fromNumberId = '434535303078523';

  TextEditingController email = TextEditingController();
  TextEditingController phnumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  String emai = "", pasword = "" ;

  registration() async {
    // final whatsapp = WhatsApp(accessToken, fromNumberId);
    setState(() {
      emai = email.text;
    pasword = password.text;
    });
    if (emai!="" && pasword!=""){
      if (pasword != "") {
        try {
          // ignore: unused_local_variable
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: emai, password: pasword);
              // print(UserCredential);
          final user = FirebaseAuth.instance.currentUser;
          user?.updateDisplayName(name.text);
          await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
                    "phno" : phnumber.text,
      
          });

          // print("Sending whatsapp message");

          // var res = await whatsapp.sendMessage(
          //   phoneNumber: phnumber.text,
          //   text: "Hi ${user?.displayName},\n\nThanks for signing up for Click and Collect! We're excited to have you join our community.\n\nGet ready to enjoy delicious food delivered right to your doorstep.\n\nStart exploring our wide range of options and place your first order today!\n\nHappy eating!\nThe Click and Collect Team",
          //   previewUrl: true
          // );

          // adduserdetails("name");

           ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            ))));
            
          Navigator.of(context).pushReplacementNamed('/');
          
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
              backgroundColor:Color(0XFFEE0000),
              content: Text(
                "Account Already exsists",
                style: TextStyle(fontSize: 18.0),
              )));
          }
        }
    }}
    else{
      if (emai == ""){
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
              height: sheight*(270/sheight),),


              const Text("Register",
              style: TextStyle(
                fontFamily: "Itim",
                fontSize: 50,
                shadows: [Shadow(color: Color(0X3F000000),offset: Offset(0, 4))]
              ),
              textAlign: TextAlign.center,),


              SizedBox(height: sheight*(30/sheight)),

              SizedBox(
                width: swidth*.8,
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder()
                  ),
                ),
              ),

              SizedBox(height: sheight*(30/sheight)),

              SizedBox(
                width: swidth*.8,
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
                width: swidth*.8,
                child: TextFormField(
                  controller: phnumber,
                  decoration: const InputDecoration(
                    labelText: "Phone number",
                    border: OutlineInputBorder()
                  ),
                ),
              ),

              SizedBox(height: sheight*(30/sheight)),


              SizedBox(
                width: swidth*.8,
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
                width: swidth*.8,
                height: sheight *(60/sheight),
                child: ElevatedButton(onPressed:registration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFEE0000),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                ),
                child: const Text(
                  "Register",
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
                  const Text("Already have an account?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                  )),
                  TextButton(onPressed: () {Navigator.of(context).pushNamed("/");},
                    child: const Text("Login",style: TextStyle(
                    fontSize: 20,
                    color: Colors.black)
                  ),)
                ],
              ),


            ],
          ),
        ),
      );
  }
}