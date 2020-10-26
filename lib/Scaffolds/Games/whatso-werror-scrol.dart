import 'package:flutter/material.dart';
import 'package:ourwearprototype/Itemizer/ItemCover.dart';

class WhatSoWerror extends StatefulWidget {
  @override
  _WhatSoWerrorState createState() => _WhatSoWerrorState();
}

class _WhatSoWerrorState extends State<WhatSoWerror> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('WhatSoWerror'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Text('What why'),
          ScrollingItemCovers(
            itemCovers: [ItemsOnIt(titling: 'Whatat')],
          ),
          //BrokenItemCover(),
          ItemCoverHome(
            titling: 'whoah',
          ),
          IdkScrollingItem(),
        ],
      ),
    );
  }
}
