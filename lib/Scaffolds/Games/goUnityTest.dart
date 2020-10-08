//import 'package:ourwearprototype/flutter_unity_widget.dart';
//import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:flutter/material.dart';

/*
https://pub.dev/packages/flutter_unity_widget
https://www.youtube.com/watch?v=exNPmv_7--Q
https://github.com/juicycleff/flutter-unity-view-widget/blob/master/lib/flutter_unity_widget.dart
https://forum.unity.com/threads/failed-to-resolve-project-template-failed-to-decompress.663214/
*/

class GoUnityTestoid extends StatefulWidget {
  @override
  _GoUnityTestoidState createState() => _GoUnityTestoidState();
}

class _GoUnityTestoidState extends State<GoUnityTestoid> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  //UnityWidgetController _unityWidgetController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Go Unity Test'),
      ),
      body: Card(
        child: Stack(
          children: [
            // UnityWidget(
            //   onUnityViewCreated: onUnityCreated,
            //   onUnityMessage: onUnityMessage,
            // ),
          ],
        ),
      ),
    );
  }

  // void onUnityMessage(controller, message) {
  //   print('Received message from unity: ${message.toString()}');
  // }

  // void onUnityCreated(controller) {
  //   //this._unityWidgetController = controller;
  // }
}
