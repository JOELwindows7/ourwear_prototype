import 'dart:ffi';

import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {

  SocialButton({this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){

      },
      child: CircleAvatar(
        radius: radius,
      ),
    );
  }
}
