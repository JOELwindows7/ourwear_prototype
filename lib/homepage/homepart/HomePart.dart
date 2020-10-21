import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/Page1.dart';
import 'package:page_indicator/page_indicator.dart';
//JOELwindows7

class PagedRecommendedInHome extends StatefulWidget {
  @override
  _PagedRecommendedInHomeState createState() => _PagedRecommendedInHomeState();
}

class _PagedRecommendedInHomeState extends State<PagedRecommendedInHome> {
  final keyad = GlobalKey<PageContainerState>();
  
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class LatestBanner extends StatefulWidget {
  @override
  _LatestBannerState createState() => _LatestBannerState();
}

class _LatestBannerState extends State<LatestBanner> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
