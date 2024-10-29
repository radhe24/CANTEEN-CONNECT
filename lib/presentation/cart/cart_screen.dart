import 'package:basic_utils/basic_utils.dart';
import 'package:clickncollect/DB/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // ignore: non_constant_identifier_names
  final user = FirebaseAuth.instance.currentUser;
  // ignore: non_constant_identifier_names
  final Database DB = Database();
  
  @override
  Widget build(BuildContext context) {
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;
    return  StreamBuilder<QuerySnapshot>(
                stream: DB.getcartItems(user?.uid),
                builder: (context,snapshot){
                  if (snapshot.hasData){
                    double c =0;
                    List menulist = snapshot.data!.docs;
                    for(var i  in menulist){
                      Map<String, dynamic> d = i.data() as Map<String,dynamic>;
                      
                      c = c + d['quantity']*double.parse(d['price']);
                    }                 
                    if (menulist.isNotEmpty){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
      
          leading:IconButton(icon:  const Icon(Icons.arrow_back,size: 30,),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          }),
          // ignore: prefer_const_constructors
          title: Text("Cart",
          style: const TextStyle(
            fontFamily: "Itim",
            fontSize: 30
          ),),
          centerTitle: true, 
        ),


        bottomNavigationBar: 
              Container(
                margin: EdgeInsets.only(top: sheight*(20/sheight)),
                height: sheight*(70/sheight),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          Text("₹$c",style: const TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 30
                                  ),),
     
                        GestureDetector(
                          onTap: (){          
                            Navigator.of(context).pushNamed('/chkout');
                          },
                          child : Container(
                          height: sheight*(50/sheight),
                          width: swidth*(200/swidth),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: sheight*(5/sheight)),
                            child: const Text("Checkout",textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "Itim",
                            ),),
                          ),
                        )),
                      ],
                    )
                 
             ),


          body: ListView.builder(
                      itemCount: menulist.length,
                      itemBuilder: (context,index){
                        DocumentSnapshot doc = menulist[index];
                        // ignore: unused_local_variable
                        Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
                    
                        if (data["quantity"]==0){FirebaseFirestore.instance.collection("Users").doc(user?.uid).collection("cart").doc(data["name"]).delete();}
                        
                          return ListTile(
                          title:
                             _displaybox(data['name'].toString(), data['price'].toString(), data['image'],data["quantity"])
                        );
                        
                      },
                    ));}
                    else {
                      return Scaffold(
                        appBar: AppBar(
                            backgroundColor: Colors.white,
                              leading:IconButton(icon:  const Icon(Icons.arrow_back,size: 30,),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/home');
                              }),
                              // ignore: prefer_const_constructors
                              title: Text("Cart",
                              style: const TextStyle(
                                fontFamily: "Itim",
                                fontSize: 30
                              ),),
                              centerTitle: true, 
                            ),
                        backgroundColor: Colors.white,
                      body: Column(children: [
          
                        SizedBox(height: sheight*(50/sheight),),
          
                        const Image(image: AssetImage("assets/emptycart.png"),),
          
          
                        const Text("Your plate is empty",
                        style:  TextStyle(
                          fontFamily: "Itim",
                          fontSize: 30
                        ),),
                        SizedBox(height: sheight*(50/sheight),)
                        ,
                        ElevatedButton(onPressed: () {Navigator.of(context).pushNamed('/home');},
                              style: ElevatedButton.styleFrom(elevation: 10,backgroundColor: const Color(0XFFEE0000)
                              ),
                              child: SizedBox(
                              width: swidth * (132/swidth),
                              height: sheight * (50/sheight),
                              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.arrow_forward_outlined,color: Colors.white),
                                  Text("Order Now",style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Itim",
                                    shadows: [Shadow(color: Color(0X3F000000),offset: Offset(2, 3))]
                    ),)
                  ],
                ),
              ),
            )
                      ],),
             
                    );
                    }
                  }
                  else {
                    return const Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(child: CircularProgressIndicator()));
                  }    
                
             
            
       }     );
  }

   Widget _displaybox(String name, String price, String img, int qty){
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;

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

                    Container(
                      width: 150,
                      height: 40,
                     decoration: BoxDecoration(
                        color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [BoxShadow(
                                  color: Color(0X3F000000),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 2)   
                      )]
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance.collection("Users").doc(user?.uid).collection("cart").doc(name).update({"quantity": qty+1});
                            },
                            child:Container(
                            width: 50,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10))
                            ),
                            child: const Icon(Icons.add,size: 30,color: Colors.white),
                          )),
      
                          SizedBox(
                            width: 50,
                            child: Text("$qty",textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Itim",
                              fontSize: 20
                            ),
                            ),
                          ),


                          GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance.collection("Users").doc(user?.uid).collection("cart").doc(name).update({"quantity": qty-1});
                            },
                            child:Container(
                            width: 50,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))
                            ),
                            child: const Icon(Icons.remove,size: 30,color: Colors.white),

                          ))
                        ],
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