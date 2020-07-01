import 'dart:math';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/spareparts/RentalListView.dart';
import 'package:provider/provider.dart';

class JustLookRentalLists extends StatefulWidget {
  @override
  _JustLookRentalListsState createState() => _JustLookRentalListsState();
}

class _JustLookRentalListsState extends State<JustLookRentalLists> {
  final Pilih = Random();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;
  Future getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  void addAnItem() async {
    try {
      //var user = Provider.of<User>(context, listen: false);
      await getUserID();
      await DatabaseService().addRentalData(
        name: 'nameFaek',
        userId: '$userID',
        price: 100000,
        descriptions: 'descriptions',
        timeBorrowDay: 5,
        imager: '🤣',
        isAvailable: false,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Just Rental List'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              addAnItem();
            },
            child: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        child: RentalListView(),
      ),
    );
  }
}
