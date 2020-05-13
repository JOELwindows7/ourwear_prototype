import 'package:flutter/cupertino.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/OurWearIntro.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/Page1.dart';

class HalamanFiturView extends StatelessWidget {
  final pageController;
  final currentPageNotifier;
  HalamanFiturView({this.pageController,this.currentPageNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        children: <Widget>[
          IntroPageTrade(),
          IntroPageRent(),
        ],
        onPageChanged: (int index){
          currentPageNotifier.value = index;
        },
      ),
    );
  }
}
