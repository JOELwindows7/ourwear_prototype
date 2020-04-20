import 'package:flutter/material.dart';
import 'package:ourwearprototype/services/auth.dart';

class ProfileHome extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text('Keluar'),
            )
          ],
        ),
      ),
    );
  }
}
