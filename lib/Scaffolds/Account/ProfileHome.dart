import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/MyRentals.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/TransactionOrderList.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/shared/spareparts/EditWearerDataForm.dart';
import 'package:ourwearprototype/shared/spareparts/UserIdText.dart';
import 'package:ourwearprototype/shared/spareparts/WearerDetail.dart';

class ProfileHome extends StatelessWidget {

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {

    void trySignOut() async{
      await _auth.signOut();
    }

    Future<void> _AreYouSureLogout() async {
      // https://api.flutter.dev/flutter/material/AlertDialog-class.html
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.warning),
                Text('Yakin ingin Log out?'),
              ],
            ),
            content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Anda akan dibawa ke halaman Login / Daftar.'),
                Text('Apakah Anda ingin Log Keluar?'),
                ],
              ),
            ),
            actions: <Widget>[

              FlatButton(
                child: Text(
                  'Ya',
                  style: TextStyle(
                    color: Colors.red,
                    ),
                  ),
                onPressed: () {
                  trySignOut();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Colors.blueAccent,
                child: Text('Tidak',),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    }

    void _attemptLogoutWindow() async {
      await _AreYouSureLogout();
    }

    // https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: EditWearerDataForm(),
            );
          },
      );
    }

    final List<String> aMenuPop = ['Edit Data', 'Logout'];
    void handleSelect(String choice){
      switch(choice){
        case 'Edit Data':
          _showSettingsPanel();
          break;

        case 'Logout':
          _attemptLogoutWindow();
          break;

        default:

          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleSelect,
            itemBuilder: (BuildContext context){
              return aMenuPop.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text('$choice'),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => TransactionOrderList(),
                    )
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.featured_play_list),
                  Text('Pesanan Saya'),
                ],
              ),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MyRentals(),
                    )
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.transfer_within_a_station),
                  Text('Barang Sewaan'),
                ],
              ),
            ),
            // RaisedButton(
            //   onPressed: () async {
            //     await _auth.signOut();
            //   },
            //   child: Row(
            //     children: <Widget>[
            //       Icon(Icons.exit_to_app),
            //       Text('Keluar'),
            //     ],
            //   ),
            // ),
            UserIdText(),
            WearerDetailContains(),
          ],
        ),
      ),
    );
  }
}
