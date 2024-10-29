
import 'package:cloud_firestore/cloud_firestore.dart';



class Database{
 

  // Reading data from DB

  Stream<QuerySnapshot> getfoodItems(String category){
    final CollectionReference food = FirebaseFirestore.instance.collection('FOOD').doc(category).collection('Menu');
    final menustream = food.snapshots();

    return menustream;
  }

  Stream<QuerySnapshot> getcartItems(uid){
    final CollectionReference food = FirebaseFirestore.instance.collection('Users').doc(uid).collection('cart');
    final menustream = food.snapshots();

    return menustream;
  }
}