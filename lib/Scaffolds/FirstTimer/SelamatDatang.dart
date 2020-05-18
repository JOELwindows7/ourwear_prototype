import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/FirstTimer/HalamanFiturView.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

//https://api.flutter.dev/flutter/widgets/PageController-class.html

class SelamatDatangScaffold extends StatefulWidget {
  final Function noFeaturePage;
  SelamatDatangScaffold({this.noFeaturePage});

  @override
  _SelamatDatangScaffoldState createState() => _SelamatDatangScaffoldState(
    noFeaturePage: noFeaturePage,
  );
}

class _SelamatDatangScaffoldState extends State<SelamatDatangScaffold> {
  int pageNumber = 0;
  String goNowWord = 'Skip';
  final _pageController = PageController();
  final Function noFeaturePage;
  _SelamatDatangScaffoldState({this.noFeaturePage});
  final _currentPageNotifier = ValueNotifier<int>(0);

  void updatePageNumber(int value){
    setState(() {
      pageNumber = _currentPageNotifier.value;
      if(pageNumber == 1){
        goNowWord = 'Done';
      } else {
        goNowWord = 'Skip';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ourwear logo'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.noFeaturePage();
              },
              icon: Icon(Icons.forward),
              label: Text(
                  goNowWord
              ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: HalamanFiturView(
              currentPageNotifier: _currentPageNotifier,
              pageController: _pageController,
              updatePageNumber: updatePageNumber,
            )
          ),

        ],

      ),
      bottomNavigationBar: Row(
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
          Expanded(
              child: Text(
                  'Scroll Right',
                textAlign: TextAlign.center,
              ),
          ),
          FlatButton.icon(
              onPressed: (){
                _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut
                );
              },
              icon: Icon(Icons.arrow_forward),
            label: Text(''),
          ),
        ],
      ),
    );
  }
}

/*

HalamanFiturView(
              currentPageNotifier: _currentPageNotifier,
              pageController: _pageController,
            ),

Row(
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

                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text('hey')
              ),
            ],
          ),
 */
