import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'helpers/KhochocHelper.dart';

/*
https://api.flutter.dev/flutter/dart-core/DateTime-class.html
http://zetcode.com/db/sqlite/select/
*/

class KhochocOnlineLogg{
  final int khochocNumbers;
  final Timestamp dateTime;
  KhochocOnlineLogg({this.khochocNumbers, this.dateTime});
}

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

class KhochocOnlineListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<KhochocOnlineLogg>>.value(
        value: DatabaseService().khochocs,
      child: KhochocOnlineListBuilder(),
    );
  }
}


class KhochocOnlineTile extends StatelessWidget {
  final KhochocOnlineLogg khochocOnliner;
  KhochocOnlineTile({this.khochocOnliner});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.vibration),
        ),
        title: Text('${khochocOnliner.khochocNumbers}'),
        subtitle: Text('${khochocOnliner.dateTime.toDate()}'),
        trailing: GestureDetector(
          child: Icon(Icons.hourglass_empty),
          onTap: () {

          },
        ),
        onTap: () async {

        },
      ),
    );
  }
}

class KhochocOnlineListBuilder extends StatefulWidget {
  @override
  _KhochocOnlineListBuilderState createState() => _KhochocOnlineListBuilderState();
}

class _KhochocOnlineListBuilderState extends State<KhochocOnlineListBuilder> {
  @override
  Widget build(BuildContext context) {
    final khochocOnlines = Provider.of<List<KhochocOnlineLogg>>(context) ?? [];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: khochocOnlines.length,
      itemBuilder: (BuildContext context, int index) {
        return KhochocOnlineTile(khochocOnliner: khochocOnlines[index],);
      },
    );
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Best Penghochocs'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.blueGrey,
              indicatorColor: Colors.greenAccent,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.wifi_tethering),
                  child: Text('Online'),
                ),
                Tab(
                  icon: Icon(Icons.disc_full),
                  child: Text('Local'),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            KhochocOnlineListView(),
            createKhochocListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.hourglass_empty),
          tooltip: 'I don\'t know',
          onPressed: () async {

          },
        ),
      ),
    );
  }
}


