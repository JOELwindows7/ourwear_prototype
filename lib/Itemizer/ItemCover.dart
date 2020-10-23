import 'package:flame/images.dart';
import 'package:flutter/material.dart';
//JOELwindows7

//Small Item Cover
class ItemCoverHome extends StatefulWidget {
  final String titling;
  final String imagePath;
  ItemCoverHome({this.imagePath, this.titling});

  @override
  _ItemCoverHomeState createState() =>
      _ItemCoverHomeState(imagePath: imagePath);
}

class _ItemCoverHomeState extends State<ItemCoverHome> {
  String titling;
  String imagePath;
  _ItemCoverHomeState({this.imagePath, this.titling});

  @override
  void initState() {
    super.initState();
    if (imagePath == null || imagePath == "")
      imagePath = "lib\Itemizer\ItemCover.dart";
    if (titling == null || titling == "") titling = "Untitled";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 300.0,
      child: Column(
        children: [
          Image(
            width: 300.0,
            height: 200.0,
            image: AssetImage('asset/images/anOurwearItemCoverPlaceholder.png'),
          ),
          Text(titling),
        ],
      ),
    );
  }
}

//https://flutter.dev/docs/cookbook/lists/horizontal-list
//https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb
class ScrollingItemCovers extends StatefulWidget {
  @override
  _ScrollingItemCoversState createState() => _ScrollingItemCoversState();
}

class _ScrollingItemCoversState extends State<ScrollingItemCovers> {
  List<ItemCoverHome> itemCovers = [
    ItemCoverHome(
      titling: 'Oh hai',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (itemCovers.length <= 0)
      itemCovers.add(ItemCoverHome(
        titling: 'Empty',
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCovers.length,
        itemBuilder: (context, index) {
          return itemCovers.elementAt(index);
        },
      ),
    );
  }
}

//Dedicated Item Cover
