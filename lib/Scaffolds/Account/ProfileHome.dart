import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/MyRentals.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/TransactionOrderList.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/shared/spareparts/UserIdText.dart';
import 'package:ourwearprototype/shared/spareparts/WearerDetail.dart';

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
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => TransactionOrderList(),
                    )
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.featured_play_list),
                  Text('Pesanan Saya'),
                ],
              ),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MyRentals(),
                    )
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.transfer_within_a_station),
                  Text('Barang Sewaan'),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  Text('Keluar'),
                ],
              ),
            ),
            UserIdText(),
            WearerDetailContains(),
          ],
        ),
      ),
    );
  }
}
