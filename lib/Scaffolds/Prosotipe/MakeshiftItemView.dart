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
import 'package:ourwearprototype/shared/reusable/AnUserID.dart';
import 'package:ourwearprototype/shared/spareparts/EditCartData.dart';
import 'package:ourwearprototype/shared/spareparts/EditRentalParticularly.dart';
import 'package:ourwearprototype/shared/spareparts/RentalItemQueryMiniWindows.dart';

class MakeshiftItemView extends StatefulWidget {
  final itemID;
  final itemName;
  MakeshiftItemView({this.itemID, this.itemName});
  final AuthService _auth = AuthService();

  @override
  _MakeshiftItemViewState createState() =>
      _MakeshiftItemViewState(itemID: itemID, itemName: itemName);
  //TODO in shopee, if you had same item more than 1 for each variation, it will double one for each varation
  //TODO append typeID next to itemID which means for different type e.g. itemID-&-typeID
}

class _MakeshiftItemViewState extends State<MakeshiftItemView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final itemID;
  final itemName;
  _MakeshiftItemViewState({this.itemName, this.itemID});

  bool isMatchWithOwnerUid;
  void nowMatchOwner() {
    print('Matches with Owner ID');
    isMatchWithOwnerUid = true;
  }

  // https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
  void _showEditCartDataPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 60.0),
          child: EditCartData(
            isAddNew: false,
            itemID: itemID,
          ),
        );
      },
    );
  }

  final Pilih = Random();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  var userID;
  Future getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  void addThisToCart({itemName, itemID}) async {
    await getUserID();
    await DatabaseService(uid: userID, subID: itemID)
        .addToCart(itemName: itemName, quantity: 1, itemId: itemID);
  }

  @override
  void initState() {
    getUserID();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
    void _showEditPanel() {
      print('Show Edit Panel Now');
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SingleChildScrollView(
              child: EditRentalParticularly(
                whichIDWasIt: itemID,
              ),
            ),
          );
        },
      );
    }

    void reallyAddItToCart({itemName, itemID}) {
      addThisToCart(itemID: itemID, itemName: itemName);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Haha Rentalable'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              print('Press Edit for $itemID');
              if (isMatchWithOwnerUid) _showEditPanel();
            },
            icon: Icon(Icons.edit),
            label: Text('Edit'),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                InsideItemView(
                  itemID: itemID,
                  nowMatchOwner: nowMatchOwner,
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton.icon(
            onPressed: () {
              //Navigator.pop(context);
              reallyAddItToCart(
                itemID: itemID,
                itemName: itemName,
              );
              _showEditCartDataPanel();
            },
            icon: Icon(Icons.add_shopping_cart),
            label: Text('Add to Cart')),
        RaisedButton.icon(
            onPressed: () {
              reallyAddItToCart(
                itemID: itemID,
                itemName: itemName,
              );
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartProsotipe(),
                  ));
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
  final Function nowMatchOwner;
  InsideItemView({this.itemID, this.nowMatchOwner});

  @override
  _InsideItemViewState createState() =>
      _InsideItemViewState(itemID: itemID, nowMatchOwner: nowMatchOwner);
}

class _InsideItemViewState extends State<InsideItemView> {
  final itemID;
  final Function nowMatchOwner;
  _InsideItemViewState({this.itemID, this.nowMatchOwner});

  bool isMatchWithOwnerUid;
  void checkWhoOwner() {}

  String userID;
  AnUserID anUserID = AnUserID();
  void getUserID() {
    userID = anUserID.whatUserID();
  }

  @override
  void initState() {
    getUserID();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rental>(
      stream: DatabaseService(uid: itemID).particularRentalData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          getUserID();
          Rental item = snapshot.data;
          print('This belongs to ${item.userId}, And You Are ${userID}');
          if (item.userId == userID) {
            print('This is your own item');
            isMatchWithOwnerUid = true;
            nowMatchOwner();
          } else {
            print('This is someone\' item');
            isMatchWithOwnerUid = false;
          }

          return Container(
            child: Column(
              children: <Widget>[
                Image.network(item.imager) ??
                    Text(
                        '${item.imager}'), // Query image url, if not found, appears the text
                Text('${item.nama}'),
                Text(
                    '${item.price} untuk ${item.timeBorrowDay} hari'), //TODO implement negotiatable boolean
                Row(
                  children: <Widget>[
                    Text('Milik '),
                    SiapaUserIDThis(
                      uid: item.userId,
                    ),
                  ],
                ),
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
