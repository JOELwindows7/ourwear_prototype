import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ourwearprototype/Scaffolds/Games/KhochocHighscore.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/brew.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:provider/provider.dart';


class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  final CollectionReference wearerCollection = Firestore.instance.collection('wearers');
  final CollectionReference rentalCollection = Firestore.instance.collection('rentals');
  final CollectionReference khochocCollection = Firestore.instance.collection('KhochocHighScore');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Future updateWearerData(String name, String phone, String address) async {
    return await wearerCollection.document(uid).setData({
      'name': name,
      'phone' : phone,
      'address' : address,
    });
  }

  Future updateRentalData(String name, String userId, String price, String descriptions, int timeBorrowDay, String imager) async {
    return await rentalCollection.document(uid).setData({
      'imager' : imager,
      'nama' : name,
      'userId' : userId,
      'price' : price,
      'descriptions' : descriptions,
      'timeBorrowDay' : timeBorrowDay,
    });
  }

  Future addRentalData(String name, String userId, String price, String descriptions, int timeBorrowDay, String imager) async {
    return await rentalCollection.add({
      'imager' : imager,
      'nama' : name,
      'userId' : userId,
      'price' : price,
      'descriptions' : descriptions,
      'timeBorrowDay' : timeBorrowDay,
    });
  }

  Future addKhochocHighscores(int khochocNumbers, DateTime date) async{
    return await khochocCollection.add({
      'khochocNumbers' : khochocNumbers,
      'date' : date,
    });
  }

  Future updateCartItemData(String itemId, int quantity, String rentalReferencePath) async {
    //TODO: query rental list, get the item refered by ID
    var tempQuantity = quantity;
    return await wearerCollection.document(uid).collection('cartItems').document(itemId).setData({
      'itemId' : itemId,
      'quantity' : tempQuantity,
      'rentalReference' : rentalCollection.reference().document(itemId),
    });
  }

  Future addToCart(String itemId, int quantity) async{
    await updateCartItemData(itemId, quantity, 'rental/$itemId');
  }
  // https://stackoverflow.com/questions/46568850/what-is-firestore-reference-data-type-good-for
  // https://firebase.google.com/docs/firestore/manage-data/add-data

  Future updateTransactionOrderListData(String itemId, int quantity, DateTime orderedAt) async {
    //TODO: query rental list, get the item refered by ID
    var tempQuantity = quantity;
    return await wearerCollection.document(uid).collection('TransactionOrderList').document(itemId).setData({
      'cartId' : itemId,
      'rentalReference' : rentalCollection.reference().document(itemId),
      'quantity' : tempQuantity,
      'orderedAt' : orderedAt,
    });
  }

  Future addTransactionOrderListData(String itemId, int quantity, DateTime orderedAt) async {
    //TODO: query rental list, get the item refered by ID
    var tempQuantity = quantity;
    return await wearerCollection.document(uid).collection('TransactionOrderList').add({
      'cartId' : itemId,
      'rentalReference' : rentalCollection.reference().document(itemId),
      'quantity' : tempQuantity,
      'orderedAt' : orderedAt,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList();
  }

  List<KhochocOnlineLogg> _khochocListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((e) {
      return KhochocOnlineLogg(
        khochocNumbers: e.data['khochocNumbers'] ?? 0,
        dateTime: e.data['date'] ?? Timestamp.now(),
      );
    }).toList();
  }

  List<Rental> _rentalListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((e) {
      return Rental(
        nama: e.data['nama'] ?? '<an item>',
        userId: e.data['userId'] ?? '<item owner>',
        imager: e.data['imager'] ?? 'Re',
        price: e.data['price'] ?? '<price tag>',
        descriptions:  e.data['descriptions'] ?? '',
        timeBorrowDay: e.data['timeBorrowDay'] ?? 0,
      );
    }).toList();
  }

  List<CartItem> _cartItemDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((e){
      return CartItem(
        itemUid: e.data['itemId'] ?? '<itemID>',
        itemName: e.data['nama'] ?? '<ItemName>',
        rentalReference: e.data['rentalReference'] ?? 'Rental()',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  Wearer _wearerDataFromSnapshot(DocumentSnapshot snapshot){
    return Wearer(
      uid: uid,
      nama: snapshot.data['nama'],
      phone: snapshot.data['phone'],
      address: snapshot.data['address'],
    );
  }



  // get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  Stream<List<Rental>> get rentals{
    return rentalCollection.snapshots()
        .map(_rentalListFromSnapshot);
  }

  Stream<List<KhochocOnlineLogg>> get khochocs{
    return khochocCollection.snapshots()
        .map(_khochocListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  Stream<Wearer> get wearerData{
    return wearerCollection.document(uid).snapshots()
        .map(_wearerDataFromSnapshot);
  }

  Stream<List<CartItem>> get cartItemsData{
    return wearerCollection.document(uid).collection('cartItems').snapshots()
        .map(_cartItemDataFromSnapshot);
  }
}