import 'package:flutter/cupertino.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/Pages/Page1.dart';

class HalamanFiturView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        children: <Widget>[
          Page1(),
          Page1(),
        ],
      ),
    );
  }
}
