import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/CartProsotipe.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/spareparts/EditCartData.dart';
import 'package:ourwearprototype/shared/spareparts/RentalItemQueryMiniWindows.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OopsStack {
  final int wasIndex;
  final CartItem thingy;
  OopsStack(this.wasIndex, this.thingy);
}

class CartItemListView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function setWhichUndoDisable;
  final Function turnOnUndo;
  final Function turnOffUndo;
  CartItemListView(
      {this.scaffoldKey,
      this.setWhichUndoDisable,
      this.turnOnUndo,
      this.turnOffUndo});

  @override
  _CartItemListViewState createState() => _CartItemListViewState(
      scaffoldKey: scaffoldKey,
      setWhichUndoDisable: setWhichUndoDisable,
      turnOnUndo: turnOnUndo,
      turnOffUndo: turnOffUndo);
}

class _CartItemListViewState extends State<CartItemListView> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Pilih = Random();

  final Function setWhichUndoDisable;
  final Function turnOnUndo;
  final Function turnOffUndo;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<OopsStack> undoStacks = [];
  bool undoDisabled = true;

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer;
  String patho = '../asset/audio/explosionLoud.wav';
  String localFilePath;
  Future playThat() async {
    int result = await audioPlayer.play(patho, isLocal: true);
  }

  Future loadThat() async {
    audioPlayer = await AudioCache().play(patho);
  }

  void doThisUndo() async {
    await getUserID();
    await DatabaseService(uid: userID).addToCart(
      itemId: undoStacks.last.thingy.itemUid,
      itemName: undoStacks.last.thingy.itemName,
      quantity: undoStacks.last.thingy.quantity,
    );
    undoStacks.removeLast();
  }

  // https://stackoverflow.com/questions/49351648/how-do-i-disable-a-button-in-flutter
  void checkUndoNow() {
    //scaffoldKey.currentState.removeCurrentSnackBar();
//    if(undoStacks.isNotEmpty){
//      getUserID();
//      setState(() {
//        undoStacks.removeLast();
//        undoDisabled = undoStacks.isNotEmpty;
//      });
//    } else {
//      setState(() {
//        undoDisabled = true;
//      });
//
//    }
    setState(() {
      undoDisabled = undoStacks.isEmpty;
      //setWhichUndoDisable(undoDisabled);
      if (undoDisabled) {
        turnOffUndo();
      } else {
        turnOnUndo();
      }
    });

    print('AAAAAAAAAAAAAAAA Undo Disablement = $undoDisabled');
  }

  //https://medium.com/flutter-community/firestore-crud-in-flutter-a-complete-guide-67755a8afc43
  // https://www.youtube.com/watch?v=1PhAPWzGaM4&list=PLdTodMosi-Bzj6RIC2wGIkAxKtXPxDtca&index=4&t=0s

  var userID;
  Future getUserID() async {
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

  _CartItemListViewState(
      {this.scaffoldKey,
      this.setWhichUndoDisable,
      this.turnOnUndo,
      this.turnOffUndo});
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    return StreamBuilder<List<CartItem>>(
      stream: DatabaseService(uid: userID).cartItemsData,
      builder: (context, snapshot) {
        //Wearer wearer = snapshot.data;
        List<CartItem> cartItems = snapshot.data;
        print('cart items s = $cartItems');
        print('cart of $userID');
        //List<CartItem> importCartItems = cartItems;
        if (snapshot.hasData) {
          print('Loaded $cartItems');
          return ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(cartItems[index].itemUid),
                  child: CartItemTile(
                    cartItem: cartItems[index],
                    checkOutThisOne: cartItems[index].checkoutThis,
                  ),
                  onDismissed: (direction) async {
                    print(
                        "Remove $index which is ${cartItems[index].itemName}");
                    getUserID();
                    undoStacks.add(OopsStack(index, cartItems[index]));
                    await DatabaseService(uid: userID)
                        .deleteCartItemData(itemID: cartItems[index].itemUid);
                    scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Wendelete ${cartItems[index].itemName}'),
                        action: SnackBarAction(
                          onPressed: () async {
                            doThisUndo();
                            checkUndoNow();
                          },
                          label: 'UNDO',
                        ),
                      ),
                    );
                    checkUndoNow();
                    //loadThat();
                  },
                );
              });
        } else {
          print('Loading cart');
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
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function setWhichUndoEnabled;
  final Function turnOnUndo;
  final Function turnOffUndo;
  CartAhItDoesntWork(
      {this.scaffoldKey,
      this.setWhichUndoEnabled,
      this.turnOffUndo,
      this.turnOnUndo});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: CartItemListView(
        scaffoldKey: scaffoldKey,
        setWhichUndoDisable: setWhichUndoEnabled,
        turnOffUndo: turnOffUndo,
        turnOnUndo: turnOnUndo,
      ),
    );
  }
}

class CartItemTile extends StatefulWidget {
  final CartItem cartItem;
  final bool checkOutThisOne;
  CartItemTile({this.cartItem, this.checkOutThisOne});

  @override
  _CartItemTileState createState() =>
      _CartItemTileState(cartItem: cartItem, checkOutThisOne: checkOutThisOne);
}

class _CartItemTileState extends State<CartItemTile> {
  final CartItem cartItem;
  final bool checkOutThisOne;
  bool _isCheckout = true;
  _CartItemTileState({this.cartItem, this.checkOutThisOne});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;

  Future getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  void _showEditCartDataPanel({String itemIDYes}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 60.0),
          child: EditCartData(
            isAddNew: false,
            itemID: itemIDYes,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _isCheckout = checkOutThisOne;
    getUserID();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () {
            _showEditCartDataPanel(itemIDYes: cartItem.itemUid);
          },
          leading: Checkbox(
            onChanged: (value) {
              getUserID();
              setState(() {
                _isCheckout = value;
                DatabaseService(uid: userID).checkOutThisYesNo(
                    itemId: cartItem.itemUid, whichValue: _isCheckout);
              });
            },
            value: _isCheckout,
          ),
//          onChanged: (anValue){
//            print("Change Checkout to $anValue");
//            getUserID();
//            setState(() {
//              DatabaseService(uid: userID).checkOutThisYesNo(itemId: widget.cartItem.itemUid, whichValue: anValue);
//            });
//
//          },
//          value: cartItem.checkoutThis ?? false,
//          controlAffinity: ListTileControlAffinity.leading,
          title: RentalParticularName(
            itemID: widget.cartItem.itemUid,
          ),
          subtitle: RentalParticularDetail(
            itemID: widget.cartItem.itemUid,
          ),
        ),
      ),
    );
    ;
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
        itemBuilder: (context, index) {
          return CartItemTile(
            cartItem: cartItems[index],
          );
        });
  }
}

/*
https://youtu.be/Be9UH1kXFDw
https://youtu.be/RkSqPAn9szs
https://youtu.be/R9C5KMJKluE
 */

/*
CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.blue,
                child: Text('ReCa'),
              ),
 */
