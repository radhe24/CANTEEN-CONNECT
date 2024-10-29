import "dart:async";
import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";


class AcceptScreen extends StatefulWidget {
  const AcceptScreen({super.key});

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {

  Future<void> playsound() async{
    final player = AudioPlayer();
    await player.play(AssetSource("accept.mp3"));
  }


  @override
  void initState(){
    playsound();
    Timer(const Duration(seconds: 2),(){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              "Order Placed",
              style: TextStyle(fontSize: 18.0),
            )));
      Navigator.of(context).pushNamed('/home');
      super.initState();
    });
  }
  @override
  Widget build(BuildContext context) {
    // playsound();   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset("assets/accept.json"),
      ),
    );
  }
}