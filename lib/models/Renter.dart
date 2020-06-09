class Wearer{
  final String nama;
  final String phone;
  final String address;

  Wearer({this.nama,this.phone, this.address});
}

class Rental {

  final String uid; //item id
  final String userId; //who has that item
  final String nama;
  final String price;
  final String descriptions;
  final int timeBorrowDay;

  Rental({this.uid, this.userId, this.nama, this.descriptions, this.price, this.timeBorrowDay, });
}

class Cart{
  final String uid;
  final String nama;
  final String itemUid;
  final int quantity;

  Cart({this.uid, this.nama, this.itemUid, this.quantity});
}

class TransactionOrders{
  final String uid;
  final String cartUid;
  final String nama;
  final DateTime orderedAt;

  TransactionOrders({this.uid,this.cartUid,this.nama,this.orderedAt});
}