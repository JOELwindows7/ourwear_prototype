import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/reusable/AnUserID.dart';

/*
https://pub.dev/packages/flutter_spinbox
*/

class EditCartData extends StatefulWidget {
  final String itemID;
  final bool isAddNew;
  EditCartData({this.isAddNew = false, this.itemID});

  @override
  _EditCartDataState createState() =>
      _EditCartDataState(isAddNew: isAddNew, itemID: itemID);
}

class _EditCartDataState extends State<EditCartData> {
  final bool isAddNew;
  final String itemID;
  _EditCartDataState({this.isAddNew = false, this.itemID});

  final _formKey = GlobalKey<FormState>();
  bool sparse = false;

  //CartItem currentCartItem = CartItem();
  num currentQuantity;

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
    return StreamBuilder<CartItem>(
      stream:
          DatabaseService(uid: userID, subID: itemID).particularCartItemData,
      builder: (context, snapshot) {
        CartItem anItemCart = snapshot.data;
        print('for edit $anItemCart');
        if (snapshot.hasData) {
          if (!sparse) {
            //TODO what to sparse
            sparse = true;
          }

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SpinBox(
                  value: anItemCart.quantity,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  onChanged: (value) {
                    currentQuantity = value;
                  },
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          getUserID();

                          if (_formKey.currentState.validate()) {
                            Navigator.pop(context);
                            sparse = false;
                          } else {}
                        }),
                  ],
                )
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
