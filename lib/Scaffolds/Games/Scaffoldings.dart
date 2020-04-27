import 'package:flutter/material.dart';

class Staffolding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burning Scaffold'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Played'),
          ),
        ),
      ),
    );
  }
}
