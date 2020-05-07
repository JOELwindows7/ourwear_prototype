import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScreen.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScreenLess.dart';
import 'package:ourwearprototype/Scaffolds/Games/game-selector-hub.dart';
import 'package:ourwearprototype/Scaffolds/Home/FrontPageTemp.dart';

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
        child: FrontPageTemp(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GameHubScaffold()
              ),
          );
        },
        child: Icon(Icons.videogame_asset),
        hoverColor: Colors.orange,
        elevation: 0,
        tooltip: 'Mini Games',
      ),
    );
  }
}
