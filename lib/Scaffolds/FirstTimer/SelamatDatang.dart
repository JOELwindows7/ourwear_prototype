import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/FirstTimer/HalamanFiturView.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class SelamatDatangScaffold extends StatelessWidget {
  final Function noFeaturePage;
  SelamatDatangScaffold({this.noFeaturePage});
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ourwear logo'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                noFeaturePage();
              },
//              icon: Icon(Icons.forward),
              label: Text('Done')),
        ],
      ),
      body: Container(
        child: HalamanFiturView(
          currentPageNotifier: _currentPageNotifier,
          pageController: _pageController,
        ),
      ),
      bottomNavigationBar: Container(
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CirclePageIndicator(
                currentPageNotifier: _currentPageNotifier,
                itemCount: 2,
                size: 18.0,
                selectedSize: 20.0,
                dotColor: Colors.grey,
                selectedDotColor: Colors.black,
              ),
              Text('Scroll Right'),
              FlatButton.icon(
                  onPressed: (){
                    _pageController.nextPage(duration: Duration.zero);
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: null),
            ],
          ),
        ),
      ),
    );
  }
}
