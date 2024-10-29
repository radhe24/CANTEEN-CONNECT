import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 28,top: 12,right: 28),
              child: Column(
                children: [
                    _welcome(context),
                    banner_section(context),
                    categories(context)
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _welcome(BuildContext context){
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      child : Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [       
                  const Text("Welcome ,",style: TextStyle(fontSize: 40,fontFamily: "Itim")),
                       
              IconButton(onPressed: () {
                Navigator.of(context).pushNamed("/cart");
              },icon:const Icon(Icons.shopping_cart_outlined,size: 36))
          ],),

          Text("${user?.displayName}",style: const TextStyle(fontSize: 30,fontFamily: "Itim"),textAlign: TextAlign.left),

        ],
      )
    );
  }

  // ignore: non_constant_identifier_names
  Widget banner_section(BuildContext context){
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 20),
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 38,top: 32,bottom: 32),
        decoration: BoxDecoration(
          color:const Color(0XFFEE0000),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(
            color: Color(0X3F000000),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 4)
          )]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: const Text(
              "Click and\nCollect",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: 'Itim',
                fontWeight: FontWeight.w400,
                
              ),
            ),
          ),
          SizedBox(height: sheight*(18/sheight)),
          
          ElevatedButton(onPressed: () {Navigator.of(context).pushNamed('/menu',arguments: 'Snacks');},
              style: ElevatedButton.styleFrom(elevation: 10),
              child: SizedBox(
              width: swidth * (132/swidth),
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.arrow_forward_outlined,color: Colors.black),
                  Text("Order Now",style:  TextStyle(
                    color: Color(0XFFEE0000),
                    fontSize: 20,
                    fontFamily: "Itim",
                    
                  ),)
                ],
              ),
            ),
          )
        ],
        ),
    );
  }

  Widget categories(BuildContext context){
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: 30),
      child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Categories ,",style: TextStyle(fontSize: 26,fontFamily: "Itim"),textAlign: TextAlign.left,),
          
          SizedBox(height: sheight*(30/sheight)),

          // first row
          
          SizedBox(
            height: 150,
            child: ListView(
            scrollDirection: Axis.horizontal,
              children: [
                //first box
               GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/menu",arguments: "Breakfast");
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
                    child: const Text(
                    "Breakfast",
                    style: TextStyle(fontSize: 20,
                    fontFamily: "Itim",
                    ),
                    textAlign: TextAlign.center,
                  ))  
                ),
              Positioned(
                top: -10,
                left: 10,
                child: Image(image: const AssetImage('assets/idli.png'),
                width: swidth*(110/swidth),
                height: sheight*(110/sheight),
                ))])),
                // second box
               GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/menu",arguments: "Lunch");
                },
                child:Stack(
               children : [ Container(
                margin: EdgeInsets.only(top:sheight*(15/sheight),bottom:sheight*(15/sheight)
                ,left: swidth*(15/swidth),right:swidth*(15/swidth)),
                  width: swidth*(100/swidth),
                  height: sheight*(100/sheight),
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
                    child: const Text(
                    "Lunch",
                    style: TextStyle(fontSize: 20,
                    fontFamily: "Itim",
                    ),
                    textAlign: TextAlign.center,
                  ))  
                ),
               Positioned(
                top: -25,
                left: -3,
                child: Image(image: const AssetImage('assets/biryani.png'),
                width: swidth*(140/swidth),
                height: sheight*(140/sheight),
                ))])),
            
            
                GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/menu",arguments: "Snacks");
                },
                child:Stack(
               children : [ Container(
                margin: EdgeInsets.only(top:sheight*(15/sheight),bottom:sheight*(15/sheight)
                ,left: swidth*(15/swidth),right:swidth*(15/swidth)),
                  width: swidth*(100/swidth),
                  height: sheight*(100/sheight),
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
                    child: const Text(
                    "Snacks",
                    style: TextStyle(fontSize: 20,
                    fontFamily: "Itim",
                    ),
                    textAlign: TextAlign.center,
                  ))  
                ),
               Positioned(
                top: -10,
                left: -5,
                child: Image(image: const AssetImage('assets/samosa.png'),
                width: swidth*(140/swidth),
                height: sheight*(140/sheight),
                ))])),
               
            
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/menu",arguments: "Drinks");
                },
                child:Stack(
               children : [ Container(
                margin: EdgeInsets.only(top:sheight*(15/sheight),bottom:sheight*(15/sheight)
                ,left: swidth*(15/swidth),right:swidth*(15/swidth)),
                  width: swidth*(100/swidth),
                  height: sheight*(100/sheight),
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
                    child: const Text(
                    "Drinks",
                    style: TextStyle(fontSize: 20,
                    fontFamily: "Itim",
                   ),
                    textAlign: TextAlign.center,
                  ))  
                ),
               Positioned(
                top: -10,
                left: 10,
                child: Image(image: const AssetImage('assets/drinks.png'),
                width: swidth*(110/swidth),
                height: sheight*(110/sheight),
                ))])),
                // second box
               GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/menu",arguments: "Pastries");
                },
                child:  Stack(
               children : [ Container(
                margin: EdgeInsets.only(top:sheight*(15/sheight),bottom:sheight*(15/sheight)
                ,left: swidth*(15/swidth),right:swidth*(15/swidth)),
                  width: swidth*(100/swidth),
                  height: sheight*(100/sheight),
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
                    child: const Text(
                    "Pastries",
                    style: TextStyle(fontSize: 20,
                    fontFamily: "Itim",
                    ),
                    textAlign: TextAlign.center,
                  ))  
                ),
               Positioned(
                top: -10,
                left: 10,
                child: Image(image: const AssetImage('assets/pastry.png'),
                width: swidth*(110/swidth),
                height: sheight*(110/sheight),
                ))])),
                    
              ],
            ),
          )
        ],
      ),
    );
  }
}


