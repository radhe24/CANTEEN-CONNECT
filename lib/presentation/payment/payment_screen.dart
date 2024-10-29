import 'package:clickncollect/DB/database.dart';
import 'package:clickncollect/presentation/payment/upi_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // ignore: non_constant_identifier_names
  Database DB = Database();
  final user = FirebaseAuth.instance.currentUser;
  String dep = '?';
  String tax = "0.0";
  String method='Pay Method';
  TextEditingController rno = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;

    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back,size: 30,),
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },),
        // ignore: prefer_const_constructors
        title: Text("Payment",
        style: const TextStyle(
          fontFamily: "Itim",
          fontSize: 30
        ),),
        centerTitle: true, 
      ),

      // ignore: prefer_const_constructors
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              margin: const EdgeInsets.only(bottom: 20,left: 20),
              child: const Text("Delivery site",style: TextStyle(
                fontFamily: "Itim",
                fontSize: 26
              ),),
            ),
            SizedBox(
              height: sheight*(150/sheight),
              child: ListView(
                
                scrollDirection: Axis.horizontal,
                children: [
                  _boxx(swidth, sheight,"SELF","assets/self.png","0.0"),
                  _boxx(swidth, sheight,"CSE","assets/cse.png","10.89"),
                  _boxx(swidth, sheight,"ECE","assets/ece.png","9.29"),
                  _boxx(swidth, sheight,"EEE","assets/eee.png","5.28"),
                  _boxx(swidth, sheight,"MECH","assets/mech.png","12.27"),
                  _boxx(swidth, sheight,"DE","assets/de.png","11.2"),
                  _boxx(swidth, sheight,"CIVIL","assets/civil.png","15.5"),
                  _boxx(swidth, sheight,"CHEM","assets/chem.png","8.26"),
                  _boxx(swidth, sheight,"ADMIN","assets/admin.png","7.19"),
                  _boxx(swidth, sheight,"LIBRARY","assets/library.png","9.99"),
                  _boxx(swidth, sheight,"MBA","assets/MBa.png",'5.55'),
                  _boxx(swidth, sheight,"IT","assets/it.png",'11.86'),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Room Number",style: TextStyle(
                fontFamily: "Itim",
                fontSize: 26
              ),),
            ),

            Container(
                margin: const EdgeInsets.only(left: 20,top: 20),
                width: swidth*.8,
                child: TextFormField(
                  controller: rno,
                  decoration: const InputDecoration(
                    labelText: "Enter Room number",
                    border: OutlineInputBorder()
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Bill Summary",style: TextStyle(
                fontFamily: "Itim",
                fontSize: 26
              ),),
            ),

            
            StreamBuilder(
              stream: DB.getcartItems(user?.uid),
              builder: (context,snapshot){
                if (snapshot.hasData){
                  double c =0;
                  List menulist = snapshot.data!.docs;
                  for(var i  in menulist){
                    Map<String, dynamic> d = i.data() as Map<String,dynamic>;
                    
                    c = c + d['quantity']*double.parse(d['price']);
                  }
              return Container(
                margin: const EdgeInsets.all(20),
                height: sheight*(170/sheight),
                width: double.maxFinite,
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
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.shopping_bag_outlined,size: 30),
                              SizedBox(width: swidth*(10/swidth)),
                              const Text("Item Total",style: TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 24
                                    ))
                            ],
                          ),
                           Text("₹$c",style: const TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 26
                                    ),)
                                  
                        ],
                      ),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              Row(
                                children: [
                                  const Icon(Icons.percent_outlined,size: 30),
                                  SizedBox(width: swidth*(10/swidth)),
                                  const Text("Additional charges",style: TextStyle(
                                          fontFamily: "Itim",
                                          fontSize: 24
                                        )),
                                ],
                              ),
                              Text(tax,style: const TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 26))
                        ],
                      ),
                      
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              const Text("Grand Total",style: TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 26
                                    )),
                              Text("₹${c+double.parse(tax)}",style: const TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 26
                                    ),)
                                  
                        ],
                      ),
              
                      
                    ],
                  ),
                ),
              );}
              else{
                return const Text("Error");
              }}
            ),
            
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Delivery Summary",style: TextStyle(
                fontFamily: "Itim",
                fontSize: 24
              ),),
            ),


            const SizedBox(height: 10),

            Container(
                margin: const EdgeInsets.all(20),
                height: sheight*(70/sheight),
                width: double.maxFinite,
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
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.home_outlined,size: 30),
                              SizedBox(width: swidth*(10/swidth)),
                              Text(dep,style: const TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 24
                                    ))
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.meeting_room_outlined,size: 30),
                              SizedBox(width: swidth*(10/swidth)),
                              Text((rno.text=="")?"?":rno.text,style: const TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 24
                                    ))
                            ],)
                                  
                        ],
                      ),
                ),
              )
            
        ],),
      ),


      bottomNavigationBar: SizedBox(height: 70,width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                tileColor: Colors.white,
                title: Text(method,style: const TextStyle(
                  fontFamily: "Itim",
                  fontSize: 20
                ),),
                trailing: PopupMenuButton(
                  icon: const Icon(Icons.arrow_drop_up_outlined,size: 40,),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value:"COD",
                      child: Row(
                        children: [Icon(Icons.attach_money_outlined,size: 20,),Text("COD",style: TextStyle(
                          fontFamily: "Itim",fontSize: 20
                        ),)]),
                    ),
                    const PopupMenuItem(
                      value: "UPI",
                      child: Row(
                        children: [Icon(Icons.paypal_outlined,size: 20,),Text("UPI",style: TextStyle(
                          fontFamily: "Itim",fontSize: 20
                        ),)]),
                    )
                  ],
                  onSelected: (String value){
                    setState(() {
                      method=value;
                    });
                  },
                ),
              ),
            ),
      
      
      
        GestureDetector(
          onTap: () {
        if (dep==''){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0XFFEE0000),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              "Please provide Block",
              style: TextStyle(fontSize: 18.0),
            )));
        }
        if (dep!="SELF"){
         if (rno.text==''){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0XFFEE0000),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              "Please provide room number",
              style: TextStyle(fontSize: 18.0),
            )));
        }}
        else{
          if (method=='UPI'){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UpiScreen(tax, dep, rno.text)
             ));}
          else if (method == 'COD'){
            FirebaseFirestore.instance.collection("Orders").doc(user?.uid).
                          set({
                            "name" : user?.displayName,
                            "delivered":"no",
                            "phno": user?.phoneNumber,
                            "block":dep,
                            "rno":rno.text,                          
                          });
            
            Navigator.of(context).pushNamed('/accept');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              "Order Placed",
              style: TextStyle(fontSize: 18.0),
            )));
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0XFFEE0000),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text(
              "Please provide Payment Method",
              style: TextStyle(fontSize: 18.0),
            )));
          }
        }
      
      },
        child: Container(
          margin: const EdgeInsets.only(right: 30),
          alignment: Alignment.center,
          height: sheight*(50/sheight),
          width: 200,
          decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(
            color: Color(0X3F000000),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, -1)
          )]
          ),
          child:
        Container(
        alignment: Alignment.center,
          // margin: EdgeInsets.only(bottom: sheight*(30/sheight)),
          child: const Text("Pay Now",style: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 30,
                        color: Colors.white
                      ),),
        ),),
      )
                          ],
                        ),
      ),
    );
  }

  Widget _boxx(double swidth,double sheight, String name, String img,String taxx){
    return GestureDetector(
                onTap: () {
                 setState(() {
                  tax = taxx;
                  dep = name;
                     
                 });
                },
                child :Stack(
               children : [ Container(
                margin: EdgeInsets.only(top:sheight*(15/sheight),bottom:sheight*(15/sheight)
                ,left: swidth*(15/swidth),right:swidth*(15/swidth)),
                  width: swidth*(100/swidth),
                  height:sheight*(100/sheight),
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
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child:  Text(
                    name,
                    style: const TextStyle(fontSize: 20,
                    fontFamily: "Itim",
                    shadows: [Shadow(color: Color(0X3F000000),offset: Offset(0, 2))]),
                    textAlign: TextAlign.center,
                  ))  
                ),
              Positioned(
                top: -10,
                left: 10,
                child: Image(image:  AssetImage(img),
                width: swidth*(110/swidth),
                height: sheight*(110/sheight),
                ))]));
  }
}