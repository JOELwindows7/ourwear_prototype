import 'package:flutter/material.dart';

class NotFoundError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text('Not Found'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.help),
      ),
    );
  }
}
