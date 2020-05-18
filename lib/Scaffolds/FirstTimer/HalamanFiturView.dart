import 'package:flutter/cupertino.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/OurWearIntro.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/Page1.dart';

class HalamanFiturView extends StatefulWidget {
  final PageController pageController;
  final ValueNotifier currentPageNotifier;
  final Function updatePageNumber;
  HalamanFiturView({this.pageController,this.currentPageNotifier,this.updatePageNumber});

  @override
  _HalamanFiturViewState createState() => _HalamanFiturViewState();
}

class _HalamanFiturViewState extends State<HalamanFiturView> {
  final PageController pageController;
  final ValueNotifier currentPageNotifier;
  _HalamanFiturViewState({this.pageController,this.currentPageNotifier});
  final _items = [
    'Trade',
    'Rent',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: widget.pageController,
        children: <Widget>[
          IntroPageTrade(),
          IntroPageRent(),
        ],
        onPageChanged: (int index){

          widget.currentPageNotifier.value = index;
          widget.updatePageNumber(index);
        },
      ),
    );
  }
}


