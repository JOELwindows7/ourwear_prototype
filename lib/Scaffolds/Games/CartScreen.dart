import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Games/AttemptToCheckout.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/MakeShiftCheckout.dart';
import 'package:ourwearprototype/shared/spareparts/CartItemListView.dart';
import 'package:ourwearprototype/shared/spareparts/RentalListView.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _undoDisabled = true;
  void setUndoButton(bool which){
    _undoDisabled = !which;
  }
  void turnOnUndo() {
    setState(() {
      _undoDisabled = false;
    });
  }
  void turnOffUndo() {
    setState(() {
      _undoDisabled = true;
    });
  }

  void _undoNow(){
    //_scaffoldKey.currentState.removeCurrentSnackBar();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cart Screen'),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.undo),
            onPressed: _undoDisabled? null : _undoNow,
          ),
          FlatButton.icon(
              onPressed: (){
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context)=>CheckoutDoesNotWork(),
                    )
                );
              },
              icon: Icon(Icons.forward),
              label: Text('Checkout')
          ),
        ],
      ),
      body: CartAhItDoesntWork(scaffoldKey: _scaffoldKey, setWhichUndoEnabled: setUndoButton, turnOffUndo: this.turnOffUndo, turnOnUndo: this.turnOnUndo,),
    );
  }
}

// CartItemListView()
