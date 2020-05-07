import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/FirstTimer/HalamanFiturView.dart';

class SelamatDatangScaffold extends StatelessWidget {
  final Function noFeaturePage;
  SelamatDatangScaffold({this.noFeaturePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang!'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                noFeaturePage();
              },
              icon: Icon(Icons.forward),
              label: Text('Go')),
        ],
      ),
      body: Container(
        child: HalamanFiturView(),
      ),
    );
  }
}
