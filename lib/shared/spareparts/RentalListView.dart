import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:provider/provider.dart';

//https://medium.com/flutter-community/firebase-startup-logic-and-custom-user-profiles-6309562ea8b7
// https://stackoverflow.com/q/50252569/9079640
// https://youtu.be/YFCSODyFxbE
// https://stackoverflow.com/q/50252569/9079640

class RentalListView extends StatelessWidget {

  final db = Firestore.instance;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Rental>>.value(
        value: DatabaseService().rentals,
      child: RentalListBuilder(),
    );
  }
}

class RentalColumnView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class RentalFunctions{

}

class RentalTile extends StatelessWidget {
  final Rental rental;
  RentalTile({this.rental});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: (){

          },
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.black,
            child: Text(rental.imager ?? 'Re'),
          ),
          title: Text(rental.nama ?? 'An Item'),
          subtitle: Text('${rental.userId}, ${rental.price ?? 'Price'} untuk ${rental.timeBorrowDay} hari'),
        ),
      ),
    );
  }
}


class RentalListBuilder extends StatefulWidget {
  @override
  _RentalListBuilderState createState() => _RentalListBuilderState();
}

class _RentalListBuilderState extends State<RentalListBuilder> {
  @override
  Widget build(BuildContext context) {
    final rentals = Provider.of<List<Rental>>(context) ?? [];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: rentals.length,
        itemBuilder: (context, index){
          return RentalTile(rental: rentals[index],);
        }
    );
  }
}


