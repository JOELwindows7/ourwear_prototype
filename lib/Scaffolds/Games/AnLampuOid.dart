//forget what this game clones from. it was a Linux game, about lamp.
// I even forgot the gameplay

//import 'package:box2d_flame/box2d.dart';
import 'package:flutter/material.dart';

class AnLampuOid extends StatefulWidget {
  @override
  _AnLampuOidState createState() => _AnLampuOidState();
}

class _AnLampuOidState extends State<AnLampuOid> {
  bool tempLompod = false;

  List<bool> lompod;
  List deret;
  void onChangeMoid(int whichChanged, bool nowValue) {
    print('arganoid no. ' + whichChanged.toString() + nowValue.toString());
    setState(() {
      tempLompod = nowValue;
    });
    print('lompod is ' + tempLompod.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Lampu Oid'),
      ),
      body: Container(
        child: Column(
          children: [
            BoxOfCollumnLampu(
              lampID: 6,
              onChangeMoid: onChangeMoid,
              sagelar: tempLompod,
            ),
          ],
        ),
      ),
    );
  }
}

class BoxOfCollumnLampu extends StatefulWidget {
  final int lampID;
  final Function onChangeMoid;
  final bool sagelar;
  BoxOfCollumnLampu({this.sagelar, this.onChangeMoid, this.lampID});
  @override
  _BoxOfCollumnLampuState createState() => _BoxOfCollumnLampuState(
      sagelar: sagelar, onChangeMoid: onChangeMoid, lampID: lampID);
}

class _BoxOfCollumnLampuState extends State<BoxOfCollumnLampu> {
  int lampID;
  Function onChangeMoid = (int id) {
    print('an id ' + id.toString());
  };
  bool sagelar = true;
  bool _wtftristate = false;
  _BoxOfCollumnLampuState({
    this.sagelar,
    this.onChangeMoid,
    this.lampID,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: sagelar,
        tristate: _wtftristate,
        onChanged: (value) {
          setState(() {
            sagelar = value;
          });
          onChangeMoid(this.lampID, this.sagelar);
          print('presse ' + lampID.toString() + sagelar.toString());
        },
      ),
    );
  }
}

//https://levelup.gitconnected.com/fluttering-dart-b37110f4d1bf
/*
https://github.com/flutter/flutter/issues/17970
https://github.com/flutter/flutter/issues/19119
https://stackoverflow.com/questions/49216117/change-checkbox-value-with-custom-class-property
https://api.flutter.dev/flutter/material/Checkbox/tristate.html
https://www.gitmemory.com/issue/flutter/flutter/55866/621031525
https://dartpad.dev/68707dc225e30a0a5c480bddd9fb73e8
https://api.flutter.dev/flutter/material/Checkbox-class.html
https://stackoverflow.com/questions/10305195/assign-function-method-to-variable-in-dart
https://levelup.gitconnected.com/fluttering-dart-b37110f4d1bf

https://stackoverflow.com/questions/51478405/how-to-return-future-or-any-other-types-from-a-function-in-dart
https://flutterrdart.com/dart-data-types-and-variables-tutorial-with-examples/
https://pub.dev/packages/flutter_unity_widget
https://stackoverflow.com/questions/60919046/how-to-fix-build-gradle
https://forum.unity.com/threads/gradle-build-failed-with-unity-2018-3-error-while-merging-dex-archives.632086/
*/
