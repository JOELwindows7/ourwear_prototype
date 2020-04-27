//Brainstorming how does OurWear rental company works
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:quiver/async.dart';

/*
https://stackoverflow.com/questions/44579918/flutter-wrap-text-on-overflow-like-insert-ellipsis-or-fade
 */

class OurWearRoffSkets extends StatefulWidget {
  @override
  _OurWearRoffSketsState createState() => _OurWearRoffSketsState();
}

class _OurWearRoffSketsState extends State<OurWearRoffSkets> {
  String bacaTeks = 'Halo. Press Play on bottom right to start Rental.';
  int _timerStart = 5;
  int _timerCurrent = 5; //timer display;
  int _gameTimeLimit = 10;
  int _returnTimeLimit = 5; //do not late
  bool flagRentalBegun = false; //Yes I know by default they're false. but it's for safety. Don't judge!
  bool flagIsUserLateToReturn = false;
  bool flagItemOnUser = false;
  Color bekgronColor = Colors.white;

  List<String> rentalWords = [
    'Halo. Press Play on bottom right to start Rental.',
    'Delivering Item... Please wait',
    'Arrived! Enjoy your Rental. Please return after designated time.',
    'Time\'s up! Please return now before late fee in...',
    'Oh no! you late! Return item now before you will be reported!',
    'You have returned the item Late!',
    'You have returned the item On Time!',
  ];

  @override
  void initState() {
    setState(() {
      _timerCurrent = _timerStart;
      bacaTeks = rentalWords.elementAt(0);
      bekgronColor = Colors.white;
    });
    super.initState();
  }

  void startRental(){
    setState(() {
      bacaTeks = rentalWords.elementAt(1);
      bekgronColor = Colors.yellow;
    });
    CountdownTimer itemDeliveryTime = CountdownTimer(
      Duration(seconds: _timerStart),
      Duration(seconds: 1),
    );

    var sub = itemDeliveryTime.listen(null);
    sub.onData((duration){
      setState(() {
        _timerCurrent = _timerStart - duration.elapsed.inSeconds;
      });
    });

    sub.onDone((){
      print('Item has been arrived!');
      sub.cancel();
      rentalArrived();
    });
  }
  void rentalArrived(){
    setState(() {
      _timerCurrent = _gameTimeLimit;
      bacaTeks = rentalWords.elementAt(2);
      bekgronColor = Colors.green;
      flagItemOnUser = true;
    });
    CountdownTimer gameTimer = CountdownTimer(
      Duration(seconds:_gameTimeLimit),
      Duration(seconds:1),
    );

    var sub = gameTimer.listen(null);
    sub.onData((duration){
      setState(() {
        _timerCurrent = _gameTimeLimit - duration.elapsed.inSeconds;
      });
    });

    sub.onDone((){
      print('Rental Time out, press return!');
      sub.cancel();
      expectReturn();
    });
  }
  void expectReturn(){
    setState(() {
      _timerCurrent = _returnTimeLimit;
      bacaTeks = rentalWords.elementAt(3);
      bekgronColor = Colors.orange;
    });
    //item on user then has to be false;

    CountdownTimer returnTimer = CountdownTimer(
      Duration(seconds:_returnTimeLimit),
      Duration(seconds:1),
    );

    var sub = returnTimer.listen(null);
    sub.onData((duration){
      setState(() {
        _timerCurrent = _returnTimeLimit - duration.elapsed.inSeconds;
      });
    });

    sub.onDone((){
      print('Return time out');
      sub.cancel();
      if(flagItemOnUser){
        stillNotReturned();
      } else {
        finishedRental();
      }
    });
  }
  void stillNotReturned(){
    setState(() {
      flagIsUserLateToReturn = true;
      bacaTeks = rentalWords.elementAt(4);
      bekgronColor = Colors.red;
    });
  }
  void finishedRental(){
    //Function finish
    print('Rental Finished with Late = ${flagIsUserLateToReturn.toString()}; ${flagIsUserLateToReturn? 'User is late!' : 'User is on time.'}');
    //Function finish end
    setState(() {
      if(!flagIsUserLateToReturn){
        bacaTeks = rentalWords.elementAt(6);
      } else {
        bacaTeks = rentalWords.elementAt(5);
      }
      bekgronColor = Colors.white;
      flagRentalBegun = false;
      flagIsUserLateToReturn = false;
    });
  }

  void pressStartButton() async{
    if(!flagRentalBegun){
      startRental();
      setState(() {
        flagRentalBegun = true;
      });
    }
  }
  void pressReturnButton() async {
    if(flagItemOnUser && flagRentalBegun){
      setState(() {
        flagItemOnUser = false;
      });
    }
    if(flagIsUserLateToReturn){
      setState(() {

      });
      finishedRental();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roff Skets'),
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: bekgronColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible( // https://stackoverflow.com/questions/44579918/flutter-wrap-text-on-overflow-like-insert-ellipsis-or-fade
                  child: Container(
                    padding: EdgeInsets.only(right: 13.00),
                    child: Text('$bacaTeks',
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: TextStyle(

                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$_timerCurrent 🕒',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    pressReturnButton();

                  },
                  child: Text('Return'),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: (){
          pressStartButton();
        },
        tooltip: 'Start Rental',
      ),
    );
  }
}
