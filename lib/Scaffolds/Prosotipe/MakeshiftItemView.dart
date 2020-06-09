import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/CartProsotipe.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/MakeShiftCheckout.dart';

class MakeshiftItemView extends StatefulWidget {
  @override
  _MakeshiftItemViewState createState() => _MakeshiftItemViewState();
}

class _MakeshiftItemViewState extends State<MakeshiftItemView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Haha Rentalable'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton.icon(
            onPressed: (){
              //Navigator.pop(context);
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Added to Cart'),
              ));
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
