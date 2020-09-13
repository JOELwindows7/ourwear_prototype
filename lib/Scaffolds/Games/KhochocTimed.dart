/*
https://pub.dev/packages/shake#-readme-tab-
https://pub.dev/packages/shake#-example-tab-
https://stackoverflow.com/a/48597815/9079640
https://stackoverflow.com/q/40579879/9079640
https://stackoverflow.com/a/11674821/9079640
https://blog.geekyants.com/building-a-2d-game-in-flutter-a-comprehensive-guide-913f647846bc
https://medium.com/flutter-community/games-in-flutter-flame-box2d-part-2-142282a4856f
https://pub.dev/packages/fluttertoast
https://flutter.dev/docs/cookbook/design/snackbars
https://youtu.be/CArR3KTav3g
https://api.flutter.dev/flutter/material/Drawer-class.html
https://api.flutter.dev/flutter/material/Scaffold-class.html
https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
https://youtu.be/CpjfR5rG2lM
https://api.flutter.dev/flutter/material/BottomAppBar-class.html
https://api.flutter.dev/flutter/material/Drawer-class.html
https://api.flutter.dev/flutter/widgets/Expanded-class.html
https://api.flutter.dev/flutter/material/SnackBar-class.html
https://api.flutter.dev/flutter/widgets/Expanded-class.html
https://flutter.dev/docs/cookbook/navigation/navigation-basics
https://medium.com/@ksheremet/flutter-showing-snackbar-within-the-widget-that-builds-a-scaffold-3a817635aeb2
https://stackoverflow.com/a/54611581/9079640
*/

import 'package:ourwearprototype/Scaffolds/Games/helpers/KhochocHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shake/shake.dart';
import 'dart:async';
import 'dart:ui';
import 'package:quiver/async.dart';
import 'package:sqflite/sqflite.dart';

import 'KhochocHighscore.dart';

class KhochocTimed extends StatefulWidget {
  @override
  _KhochocTimedState createState() => _KhochocTimedState();
}

class _KhochocTimedState extends State<KhochocTimed> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _timerStart = 3;
  int _timerCurrent = 3;
  int _gameTimeLimit = 10;
  bool isStartedGame = false;
  int KhochocCoin = 0;
  ShakeDetector detector;
  Color bekgronColor = Colors.white;

  /*
  Databaser
   */
  KhochocDatabaser databaser = KhochocDatabaser();
  //DataBaser end

  void SnakBar(String text, String actionLabel) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(text),
      action: SnackBarAction(
        onPressed: () {},
        label: actionLabel,
      ),
    ));
  }

  List<String> KhochocWords = [
    'Press Play on Bottom right button!',
    'Get Ready',
    'Khochoc Now!',
    'Time\'s up! Press Play button on bottom right to play again.',
  ];
  String KhochocSays = 'Press Play on bottom right button!';

  void PressReadyButton() {
    if (!isStartedGame) {
      detector = ShakeDetector.autoStart(onPhoneShake: () {
        setState(() {
          if (isStartedGame) KhochocCoin++;
        });
      });
      SnakBar('Ready Khochoc', '.');
      setState(() {
        bekgronColor = Colors.yellow;
        KhochocSays = KhochocWords.elementAt(1);
        KhochocCoin = 0;
        _timerCurrent = 3;
      });
      StartTimer();
    }
  }

  void StartTimer() {
    CountdownTimer countdownTimer = CountdownTimer(
      new Duration(seconds: _timerStart),
      new Duration(seconds: 1),
    );

    var sub = countdownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _timerCurrent = _timerStart - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print('Init Countdown Done!');
      sub.cancel();
      StartGame();
    });
  }

  void StartGame() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    setState(() {
      bekgronColor = Colors.green;
      _timerCurrent = _gameTimeLimit;
      KhochocSays = KhochocWords.elementAt(2);
      isStartedGame = true;
    });

    CountdownTimer gameTimer = CountdownTimer(
      Duration(seconds: _gameTimeLimit),
      Duration(seconds: 1),
    );

    var sub = gameTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _timerCurrent = _gameTimeLimit - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print('Game Countdown Done! Player got ${KhochocCoin}');
      sub.cancel();
      StopGame();
    });
  }

  void StopGame() {
    setState(() {
      bekgronColor = Colors.white;
      isStartedGame = false;
      KhochocSays = KhochocWords.elementAt(3);
    });
    BerhentiKhochoc();
    databaser.justSubmitNow(KhochocCoin);
    SnakBar('You\'ve got ${KhochocCoin} 💰 Coins!', 'WOW!');
  }

  void initState() {
    KhochocSays = KhochocWords.elementAt(0);
    super.initState();
    setState(() {});
//    detector = ShakeDetector.autoStart(onPhoneShake: (){
//      setState(() {
//        if(isStartedGame) KhochocCoin++;
//      });
//    });
  }

  Future<void> BerhentiKhochoc() async {
    detector.stopListening();
  }

  void viewHiScore(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KhochocHighScore(),
        maintainState: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Timed Khochoc'),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Fluttertoast.showToast(msg: 'You got $KhochocCoin 💰 Coins!');
            if (detector != null) {
              detector.stopListening();
            }
            //databaser.closeDatabase();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                if (!isStartedGame) viewHiScore(context);
              },
              icon: Icon(Icons.table_chart),
              label: Text('Hi-score'))
        ],
      ),
      backgroundColor: bekgronColor,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${KhochocSays}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${_timerCurrent} 🕒',
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
                  Text('Khochoc Coin dapat'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${KhochocCoin.toString()} 💰',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PressReadyButton();
        },
        child: Icon(Icons.play_circle_outline),
      ),
    );
  }
}
