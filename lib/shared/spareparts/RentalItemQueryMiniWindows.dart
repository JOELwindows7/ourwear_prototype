//TODO item detail mini widget that uses stream builder of Rental things
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';


class RentalParticularDetail extends StatefulWidget {
  final itemID;
  RentalParticularDetail({this.itemID});

  @override
  _RentalParticularDetailState createState() => _RentalParticularDetailState(itemID: itemID);
}

class _RentalParticularDetailState extends State<RentalParticularDetail> {
  final itemID;
  _RentalParticularDetailState({this.itemID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rental>(
      stream: DatabaseService(uid: itemID).particularRentalData,
      builder: (context, snapshot){
        Rental item = snapshot.data;
        if(snapshot.hasData){
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //TODO support for not just Rupiah but also Dasandim's Kivrontz Cryptocurrency
                  Text('Rp ${item.price ?? '<Entah-Harga>'}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.green,
                    ),
                  ),
                  Text('untuk ${item.timeBorrowDay ?? '<tahu-deh>'} hari'),
                ],
              ),
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

// TODO add variation of item

class RentalParticularName extends StatefulWidget {
  final itemID;
  RentalParticularName({this.itemID});

  @override
  _RentalParticularNameState createState() => _RentalParticularNameState(itemID: itemID);
}

class _RentalParticularNameState extends State<RentalParticularName> {
  final itemID;
  _RentalParticularNameState({this.itemID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rental>(
      stream: DatabaseService(uid: itemID).particularRentalData,
      builder: (context, snapshot){
        Rental item = snapshot.data;
        if(snapshot.hasData){
          return Text('${item.nama}');
        } else {
          return Loading();
        }
      },
    );
  }
}

class SiapaUserIDThis extends StatefulWidget {
  final uid;
  SiapaUserIDThis({this.uid});

  @override
  _SiapaUserIDThisState createState() => _SiapaUserIDThisState(uid: uid);
}

class _SiapaUserIDThisState extends State<SiapaUserIDThis> {
  final uid;
  _SiapaUserIDThisState({this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Wearer>(
      stream: DatabaseService(uid: uid).wearerData,
      builder: (context, snapshot){
        Wearer siapaU = snapshot.data;
        if(snapshot.hasData){
          return Text('${siapaU.name}');
        } else {
          return Loading();
        }
      },
    );
  }
}


