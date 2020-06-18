import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:provider/provider.dart';

class WearerDetailContains extends StatefulWidget {
  @override
  _WearerDetailContainsState createState() => _WearerDetailContainsState();
}

class _WearerDetailContainsState extends State<WearerDetailContains> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Wearer>(
      stream: DatabaseService(uid: user.uid).wearerData,
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data.uid != null){
          Wearer wearerData = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50.0,
              child: Column(
                children: <Widget>[
                  Text('Nama : ${wearerData.name ?? 'pls wait'}'),
                  //Text('Alamat: ${wearerData.address}'),
                  //Text('Tel: ${wearerData.phone}'),  //Privacy streaming warning!
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: 30.0,
              child: Loading()
          );
        }
      },
    );
  }
}

class WearerDataTile extends StatefulWidget {
  @override
  _WearerDataTileState createState() => _WearerDataTileState();
}

class _WearerDataTileState extends State<WearerDataTile> {
  @override
  Widget build(BuildContext context) {
    final wearer = Provider.of<Wearer>(context);
    return Column(
      children: <Widget>[
        Text('Nama : ${wearer.name}'),
      ],
    );
  }
}

