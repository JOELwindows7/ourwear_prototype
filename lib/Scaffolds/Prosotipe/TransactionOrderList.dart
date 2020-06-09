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
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.blueGrey,
              indicatorColor: Colors.greenAccent,
              tabs: <Widget>[
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.all_inclusive),
                      Text('Semua'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.money_off),
                      Text('Belum Bayar'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.inbox),
                      Text('Dikemas'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.send),
                      Text('Dikirim'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.file_download),
                      Text('Disewa'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.keyboard_return),
                      Text('Pengembalian'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.check),
                      Text('Selesai'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.cancel),
                      Text('Batal'),
                    ],
                  ),
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
