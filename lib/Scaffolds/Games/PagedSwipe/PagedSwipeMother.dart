import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/Page1.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

// https://api.flutter.dev/flutter/widgets/PageView-class.html
// https://pub.dev/packages/page_view_indicators

class PagedSwipeScaffold extends StatefulWidget {
  @override
  _PagedSwipeScaffoldState createState() => _PagedSwipeScaffoldState();
}

class _PagedSwipeScaffoldState extends State<PagedSwipeScaffold> {
  final _pageController = PageController(
    initialPage: 0,
  );

  final _currentPageNotifier = ValueNotifier<int>(0);

  final _boxHeight = 150.0;

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: 7,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paged View'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView(
              children: <Widget>[
                Page1(),
                Page1(),
                Page1(),
                Page1(),
                Page1(),
                Page1(),
                Page1(),
              ],
              controller: _pageController,
              onPageChanged: (int index){
                _currentPageNotifier.value = index;
              },
            ),
            _buildCircleIndicator(),
          ],
        ),
      ),
    );
  }
}



