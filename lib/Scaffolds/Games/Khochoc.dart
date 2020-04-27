import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shake/shake.dart';

class Khochoc extends StatefulWidget {
  @override
  _KhochocState createState() => _KhochocState();
}

class _KhochocState extends State<Khochoc> {
  int KhochocCoin = 0;
  ShakeDetector detector;
  void initState(){
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: (){
      setState(() {
        KhochocCoin++;
      });
    });
  }
  Future<void> BerhentiKhochoc() async {
    detector.stopListening();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Fluttertoast.showToast(msg: 'You got $KhochocCoin Coins!');
            detector.stopListening();
            Navigator.pop(context);
          },
        ),
        title: Text('Khochoc'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Khochoc Coin dapat'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${KhochocCoin.toString()}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
