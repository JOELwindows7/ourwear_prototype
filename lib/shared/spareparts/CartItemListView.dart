import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemListView extends StatefulWidget {
  @override
  _CartItemListViewState createState() => _CartItemListViewState();
}

class _CartItemListViewState extends State<CartItemListView> {
  final Pilih = Random();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;
  Future getUserID() async{
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<List<CartItem>>(
      stream: DatabaseService(uid: userID).cartItemsData,
      builder: (context, snapshot){
        //Wearer wearer = snapshot.data;
        List<CartItem> cartItems = snapshot.data;
        print('cart items = $cartItems');
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: cartItems.length,
              itemBuilder: (context, index){
                return CartItemTile(
                  cartItem: cartItems[index],
                );
              }
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class CartItemRebros extends StatelessWidget {
  final whichUser;
  CartItemRebros({this.whichUser});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CartItem>>.value(
        value: DatabaseService(uid: whichUser).cartItemsData,
      child: CartItemListBuilder(),
    );
  }
}

class CartAhItDoesntWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
      child: CartItemListView(),
    );
  }
}



class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  CartItemTile({this.cartItem});

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
            backgroundColor: Colors.blue,
            child: Text('ReCa'),
          ),
          title: Text(cartItem.itemName ?? 'An Item'),
          subtitle: Text('aaa'),
        ),
      ),
    );;
  }
}

class CartItemListBuilder extends StatefulWidget {
  @override
  _CartItemListBuilderState createState() => _CartItemListBuilderState();
}

class _CartItemListBuilderState extends State<CartItemListBuilder> {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<List<CartItem>>(context) ?? [];
    return ListView.builder(
      scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cartItems.length,
        itemBuilder: (context, index){
          return CartItemTile(cartItem: cartItems[index],);
        }
    );
  }
}


