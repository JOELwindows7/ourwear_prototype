import 'package:flutter/material.dart';
import 'package:ourwearprototype/shared/loading.dart';
//JOELwindows7

class ItemsOnIt {
  final String itemId;
  final String titling;
  final String imagePath;
  ItemsOnIt({this.titling, this.imagePath, this.itemId});
}

//Small Item Cover
class ItemCoverHome extends StatefulWidget {
  final String titling;
  final String imagePath;
  ItemCoverHome({this.imagePath, this.titling});

  @override
  _ItemCoverHomeState createState() =>
      _ItemCoverHomeState(imagePath: imagePath, titling: titling);
}

class _ItemCoverHomeState extends State<ItemCoverHome> {
  final String titling;
  final String imagePath;
  _ItemCoverHomeState({this.imagePath, this.titling});

  @override
  void initState() {
    // if (imagePath == null || imagePath == "")
    //   imagePath = "asset/images/anOurwearItemCoverPlaceholder.png";
    //if (titling == null || titling == "") titling = "Untitleda";
    print('information cover');
    print(titling);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String titleP = titling;
    String imageP = imagePath;
    print(titling);
    setState(() {
      titleP = titling;
      imageP = imagePath;
    });
    if (imageP == null || imageP == "")
      imageP = "asset/images/anOurwearItemCoverPlaceholder.png";
    if (titleP == null || titleP == "") titleP = "Untitleda";

    return Column(
      children: [
        Image(
          fit: BoxFit.contain,
          //loadingBuilder: (context, child, loadingProgress) => Loading(),
          width: 150.0,
          height: 200.0,
          image: AssetImage(imageP),
        ),
        Text(titleP),
      ],
    );
  }
}

//https://flutter.dev/docs/cookbook/lists/horizontal-list
//https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb
class IdkScrollingItem extends StatefulWidget {
  @override
  _IdkScrollingItemState createState() => _IdkScrollingItemState();
}

class _IdkScrollingItemState extends State<IdkScrollingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ItemCoverHome(
            titling: 'empty',
          ),
          ItemCoverHome(
            titling: 'Whoah',
          ),
        ],
      ),
    );
  }
}

class BrokenItemCover extends StatefulWidget {
  @override
  _BrokenItemCoverState createState() => _BrokenItemCoverState();
}

class _BrokenItemCoverState extends State<BrokenItemCover> {
  List<ItemsOnIt> itemCovers = [
    ItemsOnIt(titling: 'empty'),
    ItemsOnIt(titling: 'WHOAH'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300.0,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: itemCovers.length,
          itemBuilder: (context, index) {
            return ItemCoverHome(
              titling: itemCovers.elementAt(index).titling,
              imagePath: itemCovers.elementAt(index).imagePath,
            );
          }),
    );
  }
}

class ScrollingItemCovers extends StatefulWidget {
  //TODO harvest from itemID
  final List<ItemsOnIt> itemCovers;
  ScrollingItemCovers({this.itemCovers});
  @override
  _ScrollingItemCoversState createState() =>
      _ScrollingItemCoversState(itemCovers: itemCovers);
}

class _ScrollingItemCoversState extends State<ScrollingItemCovers> {
  final List<ItemsOnIt> itemCovers;
  _ScrollingItemCoversState({this.itemCovers});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (itemCovers.length <= 0 || itemCovers.length == null) {
    //   itemCovers = [
    //     ItemsOnIt(titling: 'Empty'),
    //   ];
    // }
  }

  @override
  Widget build(BuildContext context) {
    List<ItemsOnIt> itemsP = itemCovers;
    if (itemsP.length <= 0 || itemsP.length == null) {
      setState(() {
        itemsP = [
          ItemsOnIt(titling: 'Empty'),
        ];
      });
    }

    return Container(
      height: 225.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCovers.length,
        itemBuilder: (context, index) {
          return ItemCoverHome(
            titling: itemsP.elementAt(index).titling,
            imagePath: itemsP.elementAt(index).imagePath,
          );
          //return Container();
        },
      ),
    );
  }
}

//Dedicated Item Cover
