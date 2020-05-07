import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/StartOurWear.dart';
import 'package:ourwearprototype/Scaffolds/newStartOurWear.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:provider/provider.dart';

class StartOurWearWithAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: NewStartOurWear(),
    );
  }
}
