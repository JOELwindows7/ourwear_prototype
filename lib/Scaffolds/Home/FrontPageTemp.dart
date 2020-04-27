import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Games/game-selector-hub.dart';

class FrontPageTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
                onPressed: (){

                },
                icon: Icon(Icons.error),
                label: Row(
                  children: <Widget>[
                    Icon(Icons.warning),
                    Text('Max Sure'),
                  ],
                ),
            ),
            RaisedButton.icon(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GameHubScaffold()
                    ),
                  );
                },
                icon: Icon(Icons.videogame_asset),
                label: Text('Mini games'),
            ),
          ],
        ),
      ),
    );
  }
}
