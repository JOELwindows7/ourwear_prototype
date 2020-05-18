import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Filter/CrossfadingStarter.dart';
import 'package:ourwearprototype/Scaffolds/StartOurWear.dart';
import 'package:ourwearprototype/Scaffolds/newStartOurWear.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:ui';
import 'package:quiver/async.dart';

class StartOurWearWithAccount extends StatefulWidget {
  @override
  _StartOurWearWithAccountState createState() => _StartOurWearWithAccountState();
}

class _StartOurWearWithAccountState extends State<StartOurWearWithAccount> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: NewStartOurWear(),
    );
  }
}

/*
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
 */
