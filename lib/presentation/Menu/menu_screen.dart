// ignore_for_file: unused_local_variable

import 'package:basic_utils/basic_utils.dart';
import 'package:clickncollect/DB/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class MenuScreen extends StatefulWidget {
  final String category;
  const MenuScreen(this.category,{super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // ignore: non_constant_identifier_names
  final Database DB = Database();
  final user = FirebaseAuth.instance.currentUser;
  bool onlyveg =false;
  bool onlynv =false;

  // ignore: prefer_typing_uninitialized_variables
  var v;
  
void demo() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('Users') // suppose you have a collection named "Users"
      .doc(user?.uid).get();

  await FirebaseFirestore.instance
      .collection('Users') // suppose you have a collection named "Users"
      .doc(user?.uid)
      .get()
      .then((value) {
    documentSnapshot = value; // you get the document here
  });

  //now you can access the document field value
  setState(() {
    v = documentSnapshot['cart'];
  });
}



  @override
  Widget build(BuildContext context) {
  final double swidth = MediaQuery.of(context).size.width;
  final double sheight = MediaQuery.of(context).size.height;
  String c = widget.category;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
        leading: IconButton(icon:  const Icon(Icons.arrow_back,size: 30,),
        onPressed: () {
          Navigator.of(context).pushNamed('/home');
        }),
        title: Text("$c Menu",
        style: const TextStyle(
          fontFamily: "Itim",
          fontSize: 30
        ),),
        centerTitle: true,
        actions:[
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed("/cart");
            },
            child:const Icon(Icons.shopping_cart_outlined,size: 36)),
           SizedBox(width: swidth*(30/swidth),)
        ],
      ),

        body:Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: EdgeInsets.only(left: swidth*(20/swidth)),width:swidth*(150/swidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width:swidth*(20/swidth),height: sheight*(20/sheight),child: Image.asset("assets/veg.png")),
                      const Text("Only veg",style: TextStyle(
                      fontFamily: "Itim"
                      ,fontSize: 20
                    ),),
                      Switch(
                        
                        activeColor: Colors.green,
                        value: onlyveg, onChanged: (value){
                          if (value){
                          setState(() {
                          onlynv = false;
                          onlyveg = value;
                        });}else{
                        setState(() {
                          onlyveg = value;
                        });}
                      }),
                    ],
                  ),
                ),
                Container(margin: EdgeInsets.only(left: swidth*(30/swidth)),width: swidth*(180/swidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width:swidth*(20/swidth),height: sheight*(20/sheight),child: Image.asset("assets/non-veg.png")),
                      const Text("Only non veg",style: TextStyle(
                      fontFamily: "Itim"
                      ,fontSize: 20
                    ),),
                      Switch(
                        activeColor: Colors.red,
                        value: onlynv, onChanged: (value){
                        if (value){
                          setState(() {
                          onlyveg = false;
                          onlynv = value;
                        });}else{
                        setState(() {
                          onlynv = value;
                        });}
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
              
              stream: DB.getfoodItems(c),
              builder: (context,snapshot){
                if (snapshot.hasData){
                  List menulist = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: menulist.length,
                    itemBuilder: (context,index){
                      DocumentSnapshot doc = menulist[index];
                      // ignore: duplicate_ignore
                      // ignore: unused_local_variable
                      Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
                      if (onlyveg){
                        if (data['veg']=="yes"){
                        return ListTile(
                        title:
                           _displaybox(data['name'].toString(), data['price'].toString(), data['image'],data['available'].toString(),data['veg'],doc)
                    
                    
                      );}else{return const SizedBox();}
                      }
                      else if (onlynv){
                        if (data['veg']=="no"){
                        return ListTile(
                        title:
                           _displaybox(data['name'].toString(), data['price'].toString(), data['image'],data['available'].toString(),data['veg'],doc)
                    
                    
                      );}else{return const SizedBox();}
                      }
                      else{
                      return ListTile(
                        title:
                           _displaybox(data['name'].toString(), data['price'].toString(), data['image'],data['available'].toString(),data['veg'],doc)
                    
                    
                      );}
                    },
                  );
                }
                else {
                  return const Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(child: CircularProgressIndicator()));
                }
                  
              },
                    ),
            ),
          ],
        ) );
  }


  fetdoc(user)async{
     DocumentSnapshot pathData = await FirebaseFirestore.instance
       .collection('User')
       .doc(user?.uid)
       .get();

   if (pathData.exists) {
     Map<String, dynamic>? fetchDoc = pathData.data() as Map<String, dynamic>?;
     
     //Now use fetchDoc?['KEY_names'], to access the data from firestore, to perform operations , for eg
     return fetchDoc?['cart'].toString();
  }}


  Widget _displaybox(String name, String price, String img,String avbl,String veg,
  DocumentSnapshot doc){
    final user = FirebaseAuth.instance.currentUser;

    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;
    bool isavailable;
    if (avbl=="yes"){
        isavailable = true;
    }else{
        isavailable = false;
    }
    bool isveg;
    if (veg=="yes"){
        isveg = true;
    }else{
        isveg = false;
    }
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20,right: 20),
        width: double.maxFinite,
        height: sheight*(150/sheight),
        decoration: BoxDecoration(
           color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [BoxShadow(
                    color: Color(0X3F000000),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 4)   
        )]
        ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 15
              ,height: sheight*(150/sheight),
                child: Container(height: sheight*(10/sheight), alignment: Alignment.topCenter,margin: EdgeInsets.only(top: sheight*(20/sheight)),
                width: swidth*(10/swidth),child: isveg ? Image.asset("assets/veg.png"):Image.asset("assets/non-veg.png"),),
              ),
              SizedBox(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringUtils.capitalize(name),maxLines: 2,style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Itim",
                      fontSize: 22
                      
                    ),textAlign: TextAlign.left),
                    Text("₹$price",style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Itim",
                      fontSize: 20
                    ),textAlign: TextAlign.left,maxLines: 2,),
                    ElevatedButton(onPressed:(){
                      if (isavailable){
                          FirebaseFirestore.instance.collection("Users").doc(user?.uid).collection("cart")
                          .doc(doc.id).set({
                            "name" : name,
                            "price" : price,
                            "image" : img,
                            "quantity" : 1
                          });
                          ScaffoldMessenger.of(context).showSnackBar(( SnackBar(
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "$name added to cart",
                                style: const TextStyle(fontSize: 20.0),))));

                      }else {
                        null;
                      }
                    },
              
                  style: ElevatedButton.styleFrom(elevation: 10,backgroundColor:const Color(0XFFEE0000) ),
                  child:  SizedBox(
                  width: swidth*(100/swidth),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.add,color: Colors.white,size: 16,),
                      Text("Add to Cart",style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Itim",
                        shadows: [Shadow(color: Color(0X3F000000),offset: Offset(2, 3))]
                      ),)
                    ],
                  ),
                ),
                          )
                  ],
                ),
              ),
              Container(
                 decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(
                      color: Color(0X3F000000),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 4)   
          )]
          ),
                width: swidth*(100/swidth),
                height: sheight*(100/sheight),
                
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(img,fit: BoxFit.cover
                  )),
              )
            ],),
        );
      
  }
  
  
}