/* Box2D in Flutter Flame
* https://medium.com/flutter-community/games-in-flutter-flame-box2d-part-1-4c23a1cbc102
* https://medium.com/flutter-community/games-in-flutter-flame-box2d-part-2-142282a4856f
* https://medium.com/flutter-community/games-in-flutter-flame-box2d-part-3-dc36e90ca1ab
* https://medium.com/flutter-community/games-in-flutter-flame-box2d-final-8ddf489f1244
 */

import 'package:flame/util.dart';
import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class MazeBallScaffold extends StatefulWidget {
  @override
  _MazeBallScaffoldState createState() => _MazeBallScaffoldState();
}

class _MazeBallScaffoldState extends State<MazeBallScaffold> {
  MazeBallGame theGame = MazeBallGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: theGame.onTapDown,
              child: theGame.widget,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    print('Press Accesibility');
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.accessibility),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MazeBallGame extends Game {
  //Needed for Box2D
  static const int WORLD_POOL_SIZE = 100;
  static const int WORLD_POOL_CONTAINER_SIZE = 10;
  //Main physic object -> our game world
  World world;
  //Zero vector -> no gravity
  final Vector2 _gravity = Vector2.zero();
  Paint paint;
  //Size of the screen from the resize event
  Size screenSize;
  //Rectangle based on the size, easy to use
  Rect _screenRect;
  final int scale = 5;

  MazeBallGame(){
    world = new World.withPool(_gravity,
        DefaultWorldPool(WORLD_POOL_SIZE, WORLD_POOL_CONTAINER_SIZE));
    initialize();
  }

  //Initialize all things we need, devided by things need the size and things without
  Future initialize() async{
    //Call the resize as soon as flutter is ready
    resize(await Flame.util.initialDimensions());
  }

  void resize(Size size) {
    paint = Paint();
    paint.color = Color(0xff00ff00);
    //Store size and related rectangle
    screenSize = size;
    _screenRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    //If no size information -> leave
    if (screenSize == null) {
      return;
    }
    //Save the canvas and resize/scale it based on the screenSize
    canvas.save();
    canvas.scale(screenSize.width / scale);
    //Move the canvas 0,0 to the position of the circle we draw
    canvas.translate(_screenRect.width/2, _screenRect.height/2);
    //Simply draw the circle with a radius of 0.1 using our paint
    canvas.drawCircle(Offset(0, 0), 1, paint);
    canvas.restore();
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  void onTapDown(TapDownDetails d){
    // TODO: implement tap
  }
}
