import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
//https://pub.dev/packages/page_indicator
class AnotherPageIndicatorDemo extends StatelessWidget {
  final _pageController = PageController();
  final keya = GlobalKey<PageContainerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page Indicator pubspec'),
      ),
      body: Container(
        child: PageIndicatorContainer(
          key: keya,
          child: PageView(
            children: <Widget>[
              Text("1"),
              Text('2'),
              Text('3'),
              Text('4'),
            ],
            controller: _pageController,
          ),
          align: IndicatorAlign.bottom,
          length: 4,
          indicatorSpace: 20.0,
          padding: const EdgeInsets.all(10),
          indicatorColor: Colors.black,
          indicatorSelectorColor: Colors.blue,
          shape: IndicatorShape.circle(size: 12),
          // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
          // shape: IndicatorShape.oval(size: Size(12, 8)),
        ),
      ),
    );
  }
}
