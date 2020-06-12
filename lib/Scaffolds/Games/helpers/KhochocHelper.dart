import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourwearprototype/Scaffolds/Games/KhochocHighscore.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//https://www.codepolitan.com/mengakses-database-sqlite-dengan-flutter
//dbHelpers.dart

class KhochocDatabaser{
  static KhochocDatabaser _khochocDatabaser;
  static Database _database;

  KhochocDatabaser._createObject();
  final Pilih = Random();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;
  Future getUserID() async{
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  factory KhochocDatabaser(){
    if (_khochocDatabaser == null){
      _khochocDatabaser = KhochocDatabaser._createObject();
    }
    return _khochocDatabaser;
  }

  Future<Database> initDb() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'KhochocLogs.db';

    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Khochoc(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        khochocNumbers INTEGER, 
        date String
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('Khochoc', orderBy: 'KhochocNumbers DESC');
    return mapList;
  }

  //create databases
  Future<int> insert(KhochocLogs object) async {
    Database db = await this.database;
    int count = await db.insert('Khochoc', object.toMap());
    return count;
  }
//update databases
  Future<int> update(KhochocLogs object) async {
    Database db = await this.database;
    int count = await db.update('Khochoc', object.toMap(),
        where: 'id=?',
        whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('Khochoc',
        where: 'id=?',
        whereArgs: [id]);
    return count;
  }

  Future<List<KhochocLogs>> getKhochocList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<KhochocLogs> contactList = List<KhochocLogs>();
    for (int i=0; i<count; i++) {
      contactList.add(KhochocLogs.fromMap(contactMapList[i]));
    }
    return contactList;
  }

  Future<void> submitScoreManual(int coinsGot, String atDateTimeOf) async{
    KhochocLogs object = KhochocLogs(
      khochocNumbers: coinsGot,
      date: atDateTimeOf,
    );

    insert(object);

  }

  Future<void> submitScore(KhochocLogs object) async{
    insert(object);

    print('Save Data = ${object.toString()}');
  }

  Future<void> justSubmitNow(int coinsGot) async{
    var dateIsNow = DateTime.now();
    getUserID();
    submitScoreManual(coinsGot, dateIsNow.toString());
    DatabaseService(uid: userID).addKhochocHighscores(coinsGot, dateIsNow);
  }

  Future<void> closeDatabase() async{
    final db = await database;
    await db.close();
  }
}
