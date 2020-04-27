import 'dart:math';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AchakAchak extends StatefulWidget {
  @override
  _AchakAchakState createState() => _AchakAchakState();
}

class _AchakAchakState extends State<AchakAchak> {
  void SnakBar(String text, String actionLabel){
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text(text),
      action: SnackBarAction(
        onPressed: (){

        },
        label: actionLabel,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achak Achak'),
        backgroundColor: Colors.orange,
      ),
      body: ListView. builder(
        itemCount: 15,
          itemBuilder: (context, position){
          return Bhigi();
          }
      ),
    );
  }
}

class Bhigi extends StatefulWidget {
  @override
  _BhigiState createState() => _BhigiState();
}

class _BhigiState extends State<Bhigi> {
  void SnakBar(String text, String actionLabel){
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Text(text),
      action: SnackBarAction(
        onPressed: (){

        },
        label: actionLabel,
      ),
    ));
  }

  var Pilih = Random();
  final List<IconData> iconDatas = <IconData>[
    Icons.android,
    Icons.call,
    Icons.error,
    Icons.track_changes,
    Icons.add_a_photo,

    Icons.attach_money,
    Icons.scatter_plot,
    Icons.play_arrow,
    Icons.web,
    Icons.free_breakfast,

    Icons.warning,
  ];

  Icon randomIcon2() => Icon(iconDatas[Pilih.nextInt(iconDatas.length)]);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text('Achak Selection ${Pilih.nextInt(iconDatas.length)}'),
      isThreeLine: false,
      onTap: (){
        print('Achak Selecte ${Pilih.nextInt(iconDatas.length)}');
        SnakBar('Achak Select', '${Pilih.nextInt(iconDatas.length)}');
        Fluttertoast.showToast(
            msg: 'Achak Selecting ${Pilih.nextInt(iconDatas.length)}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      title: Row(
        children: <Widget>[
          randomIcon2(),
          Text('Achak ${Pilih.nextInt(iconDatas.length)} \$'),
        ],
      ),
    );
  }
}

