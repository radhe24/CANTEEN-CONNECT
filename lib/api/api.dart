import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{

  final _firebasemessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async{
    await _firebasemessaging.requestPermission();
    final fcm = await _firebasemessaging.getToken();
    print("Token : =>  $fcm");
  }
}