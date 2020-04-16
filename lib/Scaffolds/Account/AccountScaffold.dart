import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Account/EnterAccount.dart';

class AccountScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // https://stackoverflow.com/questions/46551268/when-the-keyboard-appears-the-flutter-widgets-resize-how-to-prevent-this
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: EnterAccount(),
    );
  }
}
