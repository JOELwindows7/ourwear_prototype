import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/reusable/AnUserID.dart';
import 'package:ourwearprototype/shared/spareparts/RentalItemQueryMiniWindows.dart';
import 'package:provider/provider.dart';

// https://stackoverflow.com/q/54230115/9079640

class TransactionOrderList extends StatefulWidget {
  @override
  _TransactionOrderListState createState() => _TransactionOrderListState();
}

class _TransactionOrderListState extends State<TransactionOrderList> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        key: _scaffoldKey,
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
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 0,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 1,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 2,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 3,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 4,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 5,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 6,),
            AllTransactionOrderListView(scaffoldKey: _scaffoldKey, forWhichStatus: 7,),
          ],
        ),
      ),
    );
  }
}

class AllTransactionOrderListView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int forWhichStatus;
  AllTransactionOrderListView({this.scaffoldKey, this.forWhichStatus = 0});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthService().user,
      child: _YessAllTransactionsRecently(scaffoldKey: scaffoldKey, forWhichStatus: forWhichStatus,),
    );
  }
}

class _YessAllTransactionsRecently extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int forWhichStatus;
  _YessAllTransactionsRecently({this.forWhichStatus, this.scaffoldKey});

  @override
  _YessAllTransactionsRecentlyState createState() => _YessAllTransactionsRecentlyState(scaffoldKey: scaffoldKey, forWhichStatus: forWhichStatus);
}

class _YessAllTransactionsRecentlyState extends State<_YessAllTransactionsRecently> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int forWhichStatus;
  _YessAllTransactionsRecentlyState({this.scaffoldKey, this.forWhichStatus});

  final AnUserID anUserID = AnUserID();
  var userID;

  @override
  void initState() {
    userID = anUserID.whatUserID();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return StreamBuilder<List<TransactionOrders>>(
      stream: DatabaseService(uid: userID).transactionOrderings,
      builder: (context, snapshot){
        List<TransactionOrders> pesanan = snapshot.data;
        List<TransactionOrders> import;
        if(forWhichStatus == 0){
          import = pesanan;
        } else {
          for(TransactionOrders andi in pesanan){
            if(andi.statusRightNow == forWhichStatus){
              import.add(andi);
            }
          }
        }

        if(snapshot.hasData){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: import.length,
              itemBuilder: (context, index){
                return TransactionOrdersTile(transactionOrders: import[index], forWhichStatus: forWhichStatus, scaffoldKey: scaffoldKey,);
              },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class TransactionOrdersTile extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TransactionOrders transactionOrders;
  final int forWhichStatus;
  TransactionOrdersTile({this.transactionOrders, this.scaffoldKey, this.forWhichStatus});

  @override
  _TransactionOrdersTileState createState() => _TransactionOrdersTileState(forWhichStatus: forWhichStatus, scaffoldKey: scaffoldKey, transactionOrders: transactionOrders);
}

class _TransactionOrdersTileState extends State<TransactionOrdersTile> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TransactionOrders transactionOrders;
  final int forWhichStatus;
  _TransactionOrdersTileState({this.transactionOrders, this.scaffoldKey, this.forWhichStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: (){

          },
          leading: Text('T'),
          title: RentalParticularName(itemID: transactionOrders.cartUid,),
          subtitle: RentalParticularDetail(itemID: transactionOrders.cartUid,),
        ),
      ),
    );
  }
}



