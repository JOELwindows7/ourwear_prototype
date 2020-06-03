import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/Page1.dart';
import 'package:ourwearprototype/Scaffolds/Games/game-selector-hub.dart';
import 'package:ourwearprototype/Scaffolds/Prosotipe/MakeshiftItemView.dart';
import 'package:page_indicator/page_indicator.dart';

class FrontPageTemp extends StatelessWidget {
  final keyad = GlobalKey<PageContainerState>();
  final keyaf = GlobalKey<PageContainerState>();
  final keyag = GlobalKey<PageContainerState>();
  final keyah = GlobalKey<PageContainerState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MakeshiftItemView()
                    ),
                  );
                },
                icon: Icon(Icons.error),
                label: Row(
                  children: <Widget>[
                    Icon(Icons.warning),
                    Text('Max Sure'),
                  ],
                ),
            ),
            RaisedButton.icon(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GameHubScaffold()
                    ),
                  );
                },
                icon: Icon(Icons.videogame_asset),
                label: Text('Mini games'),
            ),
            Container(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageIndicatorContainer(
                  align: IndicatorAlign.bottom,
                  length: 4,
                  indicatorSpace: 20.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.black,
                  indicatorSelectorColor: Colors.blue,
                  shape: IndicatorShape.circle(size: 12),
                  key: keyad,
                  child: PageView(
                    children: <Widget>[
                      Page1(),
                      Page1(),
                      Page1(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageIndicatorContainer(
                  align: IndicatorAlign.bottom,
                  length: 4,
                  indicatorSpace: 20.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.black,
                  indicatorSelectorColor: Colors.blue,
                  shape: IndicatorShape.circle(size: 12),
                  key: keyaf,
                  child: PageView(
                    children: <Widget>[
                      Page1(),
                      Page1(),
                      Page1(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageIndicatorContainer(
                  align: IndicatorAlign.bottom,
                  length: 4,
                  indicatorSpace: 20.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.black,
                  indicatorSelectorColor: Colors.blue,
                  shape: IndicatorShape.circle(size: 12),
                  key: keyag,
                  child: PageView(
                    children: <Widget>[
                      Page1(),
                      Page1(),
                      Page1(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageIndicatorContainer(
                  align: IndicatorAlign.bottom,
                  length: 4,
                  indicatorSpace: 20.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.black,
                  indicatorSelectorColor: Colors.blue,
                  shape: IndicatorShape.circle(size: 12),
                  key: keyah,
                  child: PageView(
                    children: <Widget>[
                      Page1(),
                      Page1(),
                      Page1(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
