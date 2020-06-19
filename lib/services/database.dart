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

  Future updateRentalData({String name, String userId, num price, String descriptions, int timeBorrowDay, String imager}) async {
    return await rentalCollection.document(uid).setData({
      'imager' : imager,
      'nama' : name,
      'userId' : userId,
      'price' : price,
      'descriptions' : descriptions,
      'timeBorrowDay' : timeBorrowDay,
    });
  }

  Future addRentalData({String name, String userId, num price, String descriptions, int timeBorrowDay, String imager}) async {
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

  Future updateCartItemDataMore({String itemName, String itemId, int quantity, String rentalReferencePath}) async {
    //TODO: query rental list, get the item refered by ID
    var tempQuantity = quantity;
    return await wearerCollection.document(uid).collection('cartItems').document(itemId).setData({
      'itemName' : itemName,
      'itemId' : itemId,
      'quantity' : tempQuantity,
      'rentalReference' : rentalCollection.reference().document(itemId),
    });
  }

  Future deleteCartItemData({@required String itemID}) async{
    return await wearerCollection.document(uid).collection('cartItems').document(itemID).delete();
  }

  Future touchCartItemData(String itemId) async{
    return await updateCartItemData(itemId, 0, itemId);
  }

  Future addToCart({String itemId, String itemName, int quantity}) async{
   // await touchCartItemData(itemId);
    await updateCartItemDataMore(
        itemName: itemName,
        itemId: itemId,
        quantity: quantity,
        rentalReferencePath: 'rental/$itemId',
    );
    //TODO separate container of mini stream builder of queryable rental.
  }
  // https://stackoverflow.com/questions/46568850/what-is-firestore-reference-data-type-good-for
  // https://firebase.google.com/docs/firestore/manage-data/add-data
  // https://stackoverflow.com/questions/53994972/flutter-remove-a-firebase-document-ontap



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
        uid: e.documentID,
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
        itemUid: e.data['itemId'] ?? 0,
        itemName: e.data['itemName'] ?? '<itemName>',
        quantity: e.data['quantity'] ?? 1,
        //rentalReference: e.data['rentalReference'] ?? 'Rental()',
      );
    }).toList();
  }

  List<Wearer> _wearersAllFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((e) {
      return Wearer(
        uid: e.documentID,
        name: e.data['name'] ?? 'a',
        phone: e.data['phone'] ?? 'b',
        address: e.data['address'] ?? 'c',
      );
    }).toList();
  }

  Rental _particularRentalDataFromSnapshot(DocumentSnapshot snapshot){
    return Rental(
      uid: uid,
      nama: snapshot.data['nama'],
      timeBorrowDay: snapshot.data['timeBorrowDay'],
      userId: snapshot.data['userId'] ?? '<entahlah>',
      descriptions: snapshot.data['descriptions'],
      price: snapshot.data['price'],
      available: snapshot.data['available'],
      imager: snapshot.data['imager'],
    );
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
      name: snapshot.data['name'] ?? 'a',
      phone: snapshot.data['phone'] ?? 'b',
      address: snapshot.data['address'] ?? 'c',
    );
  }

  CartItem _particularCartItemFromSnapshot(DocumentSnapshot snapshot){
    return CartItem(
      itemUid: snapshot.data['itemId'] ?? 0,
      itemName: snapshot.data['itemName'] ?? '<itemName>',
      quantity: snapshot.data['quantity'] ?? 1,
      //rentalReference: e.data['rentalReference'] ?? 'Rental()',
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

  Stream<Rental> get particularRentalData{
    return rentalCollection.document(uid).snapshots()
        .map(_particularRentalDataFromSnapshot);
  }

  Stream<Wearer> get wearerData{
    return wearerCollection.document(uid).snapshots()
        .map(_wearerDataFromSnapshot);
  }

  Stream<List<Wearer>> get wearersLists{
    return wearerCollection.snapshots()
        .map(_wearersAllFromSnapshot);
  }

  Stream<List<CartItem>> get cartItemsData{
    return wearerCollection.document(uid).collection('cartItems').snapshots()
        .map(_cartItemDataFromSnapshot);
  }
}