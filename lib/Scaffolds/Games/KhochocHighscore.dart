import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'helpers/KhochocHelper.dart';

/*
https://api.flutter.dev/flutter/dart-core/DateTime-class.html
http://zetcode.com/db/sqlite/select/
*/

class KhochocLogs{
  int id;
  int khochocNumbers;
  String date;

  //KhochocLogs({this.id, this.khochocNumbers, this.date});
  KhochocLogs({this.khochocNumbers, this.date});

  KhochocLogs.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.khochocNumbers = map['khochocNumbers'];
    this.date = map['date'];
  }

  //Get Set
  int get ID => id;
  int get Coins => khochocNumbers;
  String get Time => date;

  set Coins(int value){
    khochocNumbers = value;
  }
  set Time(String value){
    date = value;
  }
  //Get Set end

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'khochocNumbers': khochocNumbers,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Khochoc = $khochocNumbers, Date = $date';
  }
}

class KhochocHighScore extends StatefulWidget {
  @override
  _KhochocHighScoreState createState() => _KhochocHighScoreState();
}

class _KhochocHighScoreState extends State<KhochocHighScore> {
  //Databaser
  KhochocDatabaser databaser = KhochocDatabaser();
  int count = 0;
  List<KhochocLogs> logs;
  //Databasesr end

  ListView createKhochocListView(){
    //TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.vibration),
            ),
            title: Text('${this.logs[index].khochocNumbers}'),
            subtitle: Text(this.logs[index].date),
            trailing: GestureDetector(
              child: Icon(Icons.hourglass_empty),
              onTap: () {

              },
            ),
            onTap: () async {

            },
          ),
        );
      },
    );
  }

  //update contact
  void updateListView() {
    final Future<Database> dbFuture = databaser.initDb();
    dbFuture.then((database) {
      Future<List<KhochocLogs>> khochocListFuture = databaser.getKhochocList();
      khochocListFuture.then((khochocList) {
        setState(() {
          this.logs = khochocList;
          this.count = khochocList.length;
        });
      });
    });
  }

  @override
  void initState() {
    updateListView();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Penghochocs'),
      ),
      body: createKhochocListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.hourglass_empty),
        tooltip: 'I don\'t know',
        onPressed: () async {

        },
      ),
    );
  }
}


