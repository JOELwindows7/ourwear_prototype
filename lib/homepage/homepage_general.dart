import 'package:flutter/material.dart';
import 'package:ourwearprototype/homepage/homepart/HomePart.dart';
//https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html
//JOELwindows7

class HomepageGeneral extends StatefulWidget {
  @override
  _HomepageGeneralState createState() => _HomepageGeneralState();
}

class _HomepageGeneralState extends State<HomepageGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            actions: [
              FlatButton(onPressed: () {}, child: Icon(Icons.notifications))
            ],
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('OURWEAR'),
            ),
          ),
          PagedRecommendedInHome(),
          Container(
            child: Row(
              children: [
                FlatButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        //Image
                        Text('Trade')
                      ],
                    ))
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container();
            }),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
