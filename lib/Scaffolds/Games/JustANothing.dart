import 'package:flutter/material.dart';

class JustANothing extends StatefulWidget {
  @override
  _JustANothingState createState() => _JustANothingState();
}

class _JustANothingState extends State<JustANothing> {
  bool sakelar = false;
  Color bekgrond = Colors.black87;
  Color atase = Colors.blue[500];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: atase,
        title: Text('Just A Nothing'),
      ),
      body: Container(
        color: bekgrond,
        child: Center(
          child: Switch(
              value: sakelar,
              onChanged: (val) {
                if (sakelar) {
                  setState(() {
                    bekgrond = Colors.black87;
                    atase = Colors.blue[500];
                    sakelar = false;
                  });
                } else {
                  setState(() {
                    bekgrond = Colors.white;
                    atase = Colors.blue[50];
                    sakelar = true;
                  });
                }
              }),
        ),
      ),
    );
  }
}
