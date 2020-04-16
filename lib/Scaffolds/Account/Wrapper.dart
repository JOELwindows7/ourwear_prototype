import 'package:flutter/cupertino.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScaffold.dart';
import 'package:ourwearprototype/Scaffolds/Account/ProfileHome.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AccountWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    if(user==null){
      return AccountScaffold();
    } else {
      return ProfileHome();
    }
  }
}
