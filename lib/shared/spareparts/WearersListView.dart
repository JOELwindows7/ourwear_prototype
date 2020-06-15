import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:provider/provider.dart';

class WearersListView extends StatefulWidget {
  @override
  _WearersListViewState createState() => _WearersListViewState();
}

class _WearersListViewState extends State<WearersListView> {
  final Pilih = Random();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;
  Future getUserID() async{
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  var heyUser = AuthService().user;

  @override
  void initState() {
    // TODO: implement initState
    getUserID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Wearer>>.value(
        value: DatabaseService().wearersLists,
      child: WearerListBuilder(),
    );
  }
}

class WearerTile extends StatelessWidget {
  final Wearer wearer;
  WearerTile({this.wearer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: (){

          },
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.black,
            child: Text('Re'),
          ),
          title: Text(wearer.name ?? 'A User'),
          subtitle: Text('${wearer.uid}, '),
        ),
      ),
    );
  }
}

class WearerListBuilder extends StatefulWidget {
  @override
  _WearerListBuilderState createState() => _WearerListBuilderState();
}

class _WearerListBuilderState extends State<WearerListBuilder> {
  @override
  Widget build(BuildContext context) {
    final wearing = Provider.of<List<Wearer>>(context) ?? [];
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: wearing.length,
        itemBuilder: (context, index){
          return WearerTile(wearer: wearing[index],);
        }
    );;
  }
}


