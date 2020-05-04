import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/shared/loading.dart';

class LoadingTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Screen'),
        backgroundColor: Colors.blueGrey[100],
      ),
      body: Container(
        child: Loading(),
      ),
    );
  }
}
