// ignore_for_file: use_build_context_synchronously
import 'dart:math';
import 'package:clickncollect/DB/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';




// ignore: must_be_immutable
class UpiScreen extends StatefulWidget {
  String tax;
  String block;
  String rno;
  UpiScreen(this.tax,this.block,this.rno,{super.key});

  @override
  State<UpiScreen> createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen> {
  List<ApplicationMeta>? _apps;
  // ignore: non_constant_identifier_names
  Database DB = Database();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () async {
      _apps = await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
      setState(() {});
    });
  }


  Future<void> _onTap(ApplicationMeta app,String amt) async {
    

    final transactionRef = Random.secure().nextInt(1 << 32).toString();

    // ignore: unused_local_variable
    final a = await UpiPay.initiateTransaction(
      amount:amt,
      app: app.upiApplication,
      receiverName: 'CilckAndCollect',
      receiverUpiAddress: "sannathkoushik@okhdfcbank",
      transactionRef: transactionRef,
    );
    switch (a.status){
      case UpiTransactionStatus.success:
        FirebaseFirestore.instance.collection("Orders").doc(user?.uid).
                          set({
                            "name" : user?.displayName,
                            "delivered":"no",
                            "phno": user?.phoneNumber,
                            "block":widget.block,
                            "rno":widget.rno,
                            "bill":amt                            
                          });
          FirebaseFirestore.instance.collection("Orders").doc(user?.uid).collection("cart").doc().delete();

        Navigator.of(context).pushNamed("/accept");
      case UpiTransactionStatus.failure:
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color(0XFFEE0000),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text(
                "Transcation Failed",
                style: TextStyle(fontSize: 18.0),
              )));
              FirebaseFirestore.instance.collection("Orders").doc(user?.uid).collection("cart").doc().delete();
        Navigator.of(context).pushNamed("/chkout");
      default: null;
    }
  }

  Widget _androidApps(String amt) {
    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_apps != null) _appsGrid(_apps!.map((e) => e).toList(),amt),
        ],
      ),
    );
  }

    GridView _appsGrid(List<ApplicationMeta> apps,String amt) {
    apps.sort((a, b) => a.upiApplication
        .getAppName()
        .toLowerCase()
        .compareTo(b.upiApplication.getAppName().toLowerCase()));
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      // childAspectRatio: 1.6,
      physics: const NeverScrollableScrollPhysics(),
      children: apps
          .map(
            (it) => Material(
              key: ObjectKey(it.upiApplication),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap:  () async => await _onTap(it,amt),
                
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      it.iconImage(48),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.center,
                      child: Text(
                        it.upiApplication.getAppName(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back,size: 30,),
        onPressed: () {
          Navigator.of(context).pushNamed('/chkout');
        },),
        // ignore: prefer_const_constructors
        title: Text("Pay Using",
        style: const TextStyle(
          fontFamily: "Itim",
          fontSize: 30
        ),),
        centerTitle: true, 
      ),
      body: StreamBuilder(
              stream: DB.getcartItems(user?.uid),
              builder: (context,snapshot){
                if (snapshot.hasData){
                  double c =0;
                  List menulist = snapshot.data!.docs;
                  for(var i  in menulist){
                    Map<String, dynamic> d = i.data() as Map<String,dynamic>;
                    
                    c = c + d['quantity']*double.parse(d['price']);
                  }
                  double d = c + double.parse(widget.tax);
                  return _androidApps(d.toString());
                }else{
                  return const Text("Error");
                }
              }
      )
                  ,
    );
  }



}