import 'package:flutter/cupertino.dart';
import 'package:ourwearprototype/Scaffolds/Loading/SplashScreen.dart';
import 'package:ourwearprototype/Scaffolds/newStartOurWear.dart';
import 'dart:async';
import 'dart:ui';
import 'package:quiver/async.dart';

import 'StreamProviderStartOurwear.dart';

//https://api.flutter.dev/flutter/widgets/AnimatedCrossFade-class.html

// https://www.youtube.com/watch?v=PGK2UUAyE54&feature=youtu.be

class StartOurwearWithSplash extends StatefulWidget {
  @override
  _StartOurwearWithSplashState createState() => _StartOurwearWithSplashState();
}

class _StartOurwearWithSplashState extends State<StartOurwearWithSplash> {
  int _timerStart = 1;
  int _timerCurrent = 1;
  bool _openPage = false;
  bool _first = true;
  void StartTimer(){
    CountdownTimer countdownTimer = CountdownTimer(
      new Duration(seconds: _timerStart),
      new Duration(seconds:1),
    );

    var sub = countdownTimer.listen(null);
    sub.onData((duration){
      setState(() {
        _timerCurrent = _timerStart - duration.elapsed.inSeconds;
      });
    });

    sub.onDone((){
      print('Init Countdown Done!');
      sub.cancel();
      setState(() {
        _openPage = true;
        _first = false;
      });
    });
  }
  @override
  void initState() {
    StartTimer();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      firstChild: SplashScreen(),
      secondChild: StartOurWearWithAccount(),
      crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}

/*
int _timerStart = 1;
  int _timerCurrent = 1;
  bool _openPage = false;
  void StartTimer(){
    CountdownTimer countdownTimer = CountdownTimer(
      new Duration(seconds: _timerStart),
      new Duration(seconds:1),
    );

    var sub = countdownTimer.listen(null);
    sub.onData((duration){
      setState(() {
        _timerCurrent = _timerStart - duration.elapsed.inSeconds;
      });
    });

    sub.onDone((){
      print('Init Countdown Done!');
      sub.cancel();
      setState(() {
        _openPage = true;
      });
    });
  }
  @override
  void initState() {
    //StartTimer();
    // TODO: implement initState
    super.initState();
  }
 */
