import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Account/Wrapper.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
      child: AccountWrapper(),
    );
  }
}
