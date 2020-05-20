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

class CartProsotipe extends StatefulWidget {
  @override
  _CartProsotipeState createState() => _CartProsotipeState();
}

// https://bit.ly/2Cnhmki
// https://stackoverflow.com/questions/43813386/how-to-play-a-custom-sound-in-flutter
// https://youtu.be/39_HhRkXDpQ
// https://github.com/Perkedel/HexagonEngine/tree/master/Audacity/PoopostExplosion
// https://medium.com/flutter-community/how-to-add-music-audio-to-your-flutter-app-dcb6162c32d7

class _CartProsotipeState extends State<CartProsotipe> {
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
    CartItems(Icons.redeem, 'AAAAAAAAAAAA'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA'),
    CartItems(Icons.redeem, 'AAAAAAAAAAAA'),
  ];
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haha Cart'),
        actions: <Widget>[
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
              return Dismissible(
                key: ValueKey(cartItems.elementAt(index)),
                child: ListTile(
                  leading: Icon(cartItems.elementAt(index).ikon),
                  title: Text(cartItems.elementAt(index).title),
                ),
                onDismissed: (index){
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