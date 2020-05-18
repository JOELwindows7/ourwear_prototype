import 'package:flutter/material.dart';
import 'package:ourwearprototype/Filter/CrossfadingStarter.dart';
import 'package:ourwearprototype/Filter/StreamProviderStartOurwear.dart';
import 'package:ourwearprototype/Scaffolds/Account/Wrapper.dart';
import 'package:ourwearprototype/Scaffolds/StartOurWear.dart';

import 'Scaffolds/newStartOurWear.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: StartOurWearWithAccount(),
    );
  }
}

/*
https://developer.android.com/studio/build/multidex
https://stackoverflow.com/questions/36785014/the-number-of-method-references-in-a-dex-file-cannot-exceed-64k-api-17
https://stackoverflow.com/questions/57278197/receiving-error-when-creating-firebaseauth-instance-create-sign-in-with-email
https://pub.dev/packages/firebase_auth#-readme-tab-
https://firebase.google.com/docs/auth/android/password-auth
https://github.com/JOELwindows7/brew_crew
*/
