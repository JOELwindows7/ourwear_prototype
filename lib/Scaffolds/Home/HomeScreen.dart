import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScreen.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScreenLess.dart';
import 'package:ourwearprototype/Scaffolds/Games/game-selector-hub.dart';
import 'package:ourwearprototype/Scaffolds/Home/FrontPageTemp.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/CartProsotipe.dart';
import 'package:ourwearprototype/shared/spareparts/RentalListView.dart';

// Ourwear protection

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context)=> CartProsotipe(),
                      ),
                  );
                },
                icon: Icon(Icons.shopping_cart),
                label: Text(''),
            ),
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
                label: Text(''),
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    Text('Front'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.local_mall),
                    Text('Rentals'),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: Colors.green,
        ),
        body: TabBarView(
          children: <Widget>[
            FrontPageTemp(),
            RentalListView(),
          ],
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
      ),
    );
  }//
}

/*
Container(
              child: Column(
                children: <Widget>[
                  RentalListView()
                ],
              ),
            ),
 */