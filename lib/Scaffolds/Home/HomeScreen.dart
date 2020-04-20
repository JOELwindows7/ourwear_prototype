import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountScreen(),
                    ),
                );
              },
              icon: Icon(Icons.person),
              label: Text('Account')
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: Container(
        //TODO: stateful home screen contains
      ),
    );
  }
}
