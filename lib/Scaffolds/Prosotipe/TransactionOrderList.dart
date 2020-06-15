import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://stackoverflow.com/q/54230115/9079640

class TransactionOrderList extends StatefulWidget {
  @override
  _TransactionOrderListState createState() => _TransactionOrderListState();
}

class _TransactionOrderListState extends State<TransactionOrderList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pesanan Saya'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.blueGrey,
              indicatorColor: Colors.greenAccent,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.all_inclusive),
                  child: Text('Semua'),
                ),
                Tab(
                  icon: Icon(Icons.money_off),
                  child: Text('Belum Bayar'),
                ),
                Tab(
                  icon: Icon(Icons.inbox),
                  child: Text('Dikemas'),
                ),
                Tab(
                  icon: Icon(Icons.send),
                  child: Text('Dikirim'),
                ),
                Tab(
                  icon: Icon(Icons.file_download),
                  child: Text('Disewa'),
                ),
                Tab(
                  icon: Icon(Icons.keyboard_return),
                  child: Text('Pengembalian'),
                ),
                Tab(
                  icon: Icon(Icons.check),
                  child: Text('Selesai'),
                ),
                Tab(
                  icon: Icon(Icons.cancel),
                  child: Text('Batal'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //TODO: List View builder
            ListView(
              children: <Widget>[
                //TODO: use Builder instead
                //query items from here!
              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
            ListView(
              children: <Widget>[

              ],
            ),
          ],
        ),
      ),
    );
  }
}
