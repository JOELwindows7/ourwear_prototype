import 'package:flutter/material.dart';
import 'package:ourwearprototype/shared/spareparts/CartItemListView.dart';
import 'package:ourwearprototype/shared/spareparts/RentalListView.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Screen'),
      ),
      body: CartAhItDoesntWork(),
    );
  }
}

// CartItemListView()
