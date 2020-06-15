import 'package:flutter/material.dart';
import 'package:ourwearprototype/shared/spareparts/WearersListView.dart';

class WearerListsOfIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wearers Here'),
      ),
      body: WearersListView(),
    );
  }
}
