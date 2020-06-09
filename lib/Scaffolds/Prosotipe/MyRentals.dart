import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyRentals extends StatefulWidget {
  @override
  _MyRentalsState createState() => _MyRentalsState();
}

class _MyRentalsState extends State<MyRentals> {
  List<FakeMyRentals> fakeRentals = [
    FakeMyRentals('A', 'WWWWWWWWWWWWW1'),
    FakeMyRentals('B', 'WWWWWWWWWWWWW2'),
    FakeMyRentals('C', 'WWWWWWWWWWWWW3'),
    FakeMyRentals('D', 'WWWWWWWWWWWWW4'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang Sewaan'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){

              },
              icon: Icon(Icons.add),
              label: Text('Tambah Barang')),
        ],
      ),
      body: ListView.builder(
        itemCount: fakeRentals.length,
          itemBuilder: (context, index){
          return Container(
            child: ListTile(
              onTap: (){

              },
              leading: CircleAvatar(
                child: Text(fakeRentals[index].imager),
              ),
              title: Text(fakeRentals[index].name),
            ),
          );
          }
      ),
    );
  }
}

class FakeMyRentals{
  final String imager;
  final String name;

  FakeMyRentals(this.imager, this.name);
}
