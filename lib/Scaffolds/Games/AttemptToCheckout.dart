import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/spareparts/CartItemListView.dart';
import 'package:provider/provider.dart';

class AttemptToCheckout extends StatefulWidget {
  @override
  _AttemptToCheckoutState createState() => _AttemptToCheckoutState();
}

class _AttemptToCheckoutState extends State<AttemptToCheckout> {


  @override
  Widget build(BuildContext context) {


    return StreamProvider<List<CartItem>>.value(
      value: DatabaseService().cartItemsData,
      child: SubAttemptCheckout(),
    );
  }
}

class SubAttemptCheckout extends StatefulWidget {
  @override
  _SubAttemptCheckoutState createState() => _SubAttemptCheckoutState();
}

class _SubAttemptCheckoutState extends State<SubAttemptCheckout> {
  final Pilih = Random();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  List<CartItem> fakeCart =[
    CartItem(
      itemName: 'haha',
      itemUid: 0,
      quantity: 1,
      rentalReference: 'rental/0'
    ),
  ];

  var userID;
  Future getUserID() async{
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  @override
  Widget build(BuildContext context) {
    final cartTime = Provider.of<List<CartItem>>(context) ?? [];
    Future attemptCheckoutNow() async {
      getUserID();
      for(var i=0; i < cartTime.length; i++){
        DatabaseService().addTransactionOrderListData(cartTime[i].itemUid, cartTime[i].quantity, DateTime.now());
      }
      for(var i=0; i < cartTime.length; i++){
//        await Firestore.instance.runTransaction((transaction) async {
//          await transaction.delete(DatabaseService().wearerCollection.document(userID).collection('cartItems').document(cartTime[i].itemUid));
//        });
      DatabaseService().wearerCollection.document(userID).collection('cartItems').document().delete();
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Attempt To Checkout'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
                onPressed: ()async{
                  try{
                    await attemptCheckoutNow();
                  } catch(e){
                    print(e);
                  }
                },
                icon: Icon(Icons.credit_card),
                label: Text('Attempt Checkout')
            ),
            //CartItemListView(),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: fakeCart.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text('${fakeCart[index].itemUid}'),
                    leading: Icon(Icons.card_giftcard),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

