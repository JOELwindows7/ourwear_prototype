import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/CartProsotipe.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/MakeShiftCheckout.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';

class MakeshiftItemView extends StatefulWidget {
  final itemID;
  final itemName;
  MakeshiftItemView({this.itemID, this.itemName});
  final AuthService _auth = AuthService();

  @override
  _MakeshiftItemViewState createState() => _MakeshiftItemViewState(itemID: itemID, itemName: itemName);
  //TODO in shopee, if you had same item more than 1 for each variation, it will double one for each varation
  //TODO append typeID next to itemID which means for different type e.g. itemID-&-typeID
}

class _MakeshiftItemViewState extends State<MakeshiftItemView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final itemID;
  final itemName;
  _MakeshiftItemViewState({this.itemName,this.itemID});

  final Pilih = Random();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  var userID;
  Future getUserID() async{
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  void addThisToCart({itemName,itemID}) async{
    await getUserID();
    await DatabaseService(uid: userID).addToCart(itemName: itemName, quantity: 1, itemId: itemID);
  }

  @override
  Widget build(BuildContext context) {
    void reallyAddItToCart({itemName,itemID}) {
      addThisToCart(
          itemID: itemID,
          itemName: itemName
      );
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Haha Rentalable'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                InsideItemView(itemID: itemID,),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton.icon(
            onPressed: (){
              //Navigator.pop(context);
              reallyAddItToCart(
                itemID: itemID,
                itemName: itemName,
              );
            },
            icon: Icon(Icons.add_shopping_cart),
            label: Text('Add to Cart')),
        RaisedButton.icon(
            onPressed: (){
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => CartProsotipe(),
                  )
              );
            },
            icon: Icon(Icons.shopping_cart),
            label: Text('Buy Now'))
      ],
    );
  }
}

// Maybe try add Software rental? no. uh..
// Oh I know! rental hardware!! perhaps. ladder, drill, lamp, briefcase, cook ware, idk
// wash per use. the owner has to wash it everytime rent finished
// payment gateway, sandbox.

class InsideItemView extends StatefulWidget {
  final itemID;
  InsideItemView({this.itemID});

  @override
  _InsideItemViewState createState() => _InsideItemViewState(itemID: itemID);
}

class _InsideItemViewState extends State<InsideItemView> {
  final itemID;
  _InsideItemViewState({this.itemID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rental>(
      stream: DatabaseService(uid: itemID).particularRentalData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          Rental item = snapshot.data;
          return Container(
            child: Column(
              children: <Widget>[
                Text('${item.imager}'), // Query image url, if not found, appears the text
                Text('${item.nama}'),
                Text('${item.price} untuk ${item.timeBorrowDay} hari'), //TODO implement negotiatable boolean
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
