import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScaffold.dart';
import 'package:ourwearprototype/Scaffolds/Account/AccountScreen.dart';
import 'package:ourwearprototype/Scaffolds/Account/EnterAccount.dart';
import 'package:ourwearprototype/Scaffolds/Account/Wrapper.dart';
import 'package:ourwearprototype/Scaffolds/FirstTimer/HalamanFiturView.dart';
import 'package:ourwearprototype/Scaffolds/FirstTimer/SelamatDatang.dart';
import 'package:ourwearprototype/Scaffolds/Home/HomeScreen.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:provider/provider.dart';

class NewStartOurWear extends StatefulWidget {
  @override
  _NewStartOurWearState createState() => _NewStartOurWearState();
}

class _NewStartOurWearState extends State<NewStartOurWear> {
  var showFeaturePage = true;

  var hasSighted = false;

  void noFeaturePage(){
    setState(() {
      showFeaturePage = false;
      hasSighted = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user==null){
      showFeaturePage = true;
    } else {
      showFeaturePage = false;
    }

    if(showFeaturePage && !hasSighted){
      return SelamatDatangScaffold(
        noFeaturePage: noFeaturePage,
      );
    } else {
      return HomeScreen();
    }
  }
}
