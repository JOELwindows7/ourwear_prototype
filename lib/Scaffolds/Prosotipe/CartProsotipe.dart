import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';

class CartItems{
  CartItems(this.ikon,this.title);
  final IconData ikon; //asset image
  final String title;
}

class UndoStack{
  final int wasIndex;
  final CartItems thingy;
  UndoStack(this.wasIndex,this.thingy);
}

class CartProsotipe extends StatefulWidget {
  @override
  _CartProsotipeState createState() => _CartProsotipeState();
}

// https://bit.ly/2Cnhmki
// https://stackoverflow.com/questions/43813386/how-to-play-a-custom-sound-in-flutter
// https://youtu.be/39_HhRkXDpQ
// https://github.com/Perkedel/HexagonEngine/tree/master/Audacity/PoopostExplosion
// https://medium.com/flutter-community/how-to-add-music-audio-to-your-flutter-app-dcb6162c32d7
// https://flutter.dev/docs/cookbook/gestures/dismissible

class _CartProsotipeState extends State<CartProsotipe> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      audioPlayer.startHeadlessService();
    }
  }
  Future _loadFile() async {
    final bytes = await readBytes(kUrl1);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        localFilePath = file.path;
      });
    }
  }

  List<CartItems> cartItems = [
    CartItems(Icons.redeem, 'AAAAAAAAAAAA1'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA2'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA3'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA4'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA5'),
  ];
  List<UndoStack> undoStacks = [];
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer;
  String patho = '../asset/audio/explosionLoud.wav';
  String localFilePath;
  Future playThat() async {
    int result = await audioPlayer.play(patho, isLocal: true);
  }
  Future loadThat() async {
    audioPlayer = await AudioCache().play(patho);
  }

  @override
  void dispose() {
    audioPlayer = null;
    super.dispose();
  }

  bool _undoDisabled = true;

  // https://stackoverflow.com/questions/49351648/how-do-i-disable-a-button-in-flutter
  void _undoNow(){
    _scaffoldKey.currentState.removeCurrentSnackBar();
    if(undoStacks.isNotEmpty){
      setState(() {
        cartItems.insert(undoStacks.last.wasIndex, undoStacks.last.thingy);
        undoStacks.removeLast();
        if(undoStacks.isEmpty) {
          _undoDisabled = true;
        }
      });
    } else {
      setState(() {
        _undoDisabled = true;
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // https://medium.com/@ksheremet/flutter-showing-snackbar-within-the-widget-that-builds-a-scaffold-3a817635aeb2
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Haha Cart'),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.undo),
            onPressed: _undoDisabled? null : _undoNow,
          ),
          FlatButton.icon(
              onPressed: (){

              },
              icon: Icon(Icons.forward),
              label: Text('Checkout')
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          //TODO: sort items based on owner
          itemCount: cartItems.length,
          itemBuilder: (context, index){
            final tempCart = cartItems.elementAt(index);
              return Dismissible(
                //https://stackoverflow.com/questions/47735143/dismissing-a-dismissible-with-flutter-dart
                // use Unique Key generator class!
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(
                  leading: Icon(cartItems.elementAt(index).ikon),
                  title: Text(cartItems.elementAt(index).title),
                ),
                onDismissed: (direction){
                  print("Remove $index");
                  setState(() {
                    undoStacks.add(UndoStack(index, cartItems.elementAt(index)));
                    cartItems.removeAt((index));
                  });
                  // https://flutter.dev/docs/cookbook/design/snackbars
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Remove ${tempCart.title}'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: _undoNow,
                    ),
                  ));
                  if(undoStacks.isNotEmpty){
                    setState(() {
                      _undoDisabled = false;
                    });
                  }

                  //playThat();
                  loadThat();
                },
              );
            },
        ),
      ),
    );
  }
}

/*
children: <Widget>[
            //TODO: builder of cart items
            Dismissible(
              key: ValueKey("aaaa"),
              child: ListTile(
                leading: Container(
                  child: Icon(Icons.redeem),
                ),
                title: Text('Haha Rentalable'),
              ),
              background: Container(
                color: Colors.green,
              ),
            )
          ],
 */