class Wearer{

  final String uid;
  final String nama;
  final String phone;
  final String address;

  Wearer({this.uid,this.nama,this.phone, this.address});
}

class Rental {

  final String uid; //item id
  final String userId; //who has that item
  final String imager;
  final String nama;
  final String price;
  final String descriptions;
  final int timeBorrowDay;
  final bool available;
  //TODO: available status Y/N, Color Type

  Rental({this.uid, this.userId, this.nama, this.imager, this.descriptions, this.price, this.timeBorrowDay, this.available});
}

class Cart{
  final String uid; //user id. each user has own cart
  final String nama;

  Cart({this.uid, this.nama,});
}

class CartItem{
  final itemUid;
  final quantity;
  final itemName;
  final rentalReference;

  CartItem({this.itemUid, this.quantity, this.itemName, this.rentalReference});
}

class TransactionOrders{
  final String uid;
  final String cartUid;
  final String nama;
  final DateTime orderedAt;

  TransactionOrders({this.uid,this.cartUid,this.nama,this.orderedAt});
}