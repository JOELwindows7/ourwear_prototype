import 'package:flutter/material.dart';
import 'package:ourwearprototype/Itemizer/ItemCover.dart';
import 'package:ourwearprototype/homepage/homepart/HomePart.dart';
//https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html
// https://flutter.dev/docs/development/ui/advanced/slivers
//JOELwindows7

class HomepageGeneral extends StatefulWidget {
  @override
  _HomepageGeneralState createState() => _HomepageGeneralState();
}

class _HomepageGeneralState extends State<HomepageGeneral> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          actions: [
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.notifications, color: Colors.white),
            )
          ],
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('OURWEAR'),
            collapseMode: CollapseMode.parallax,
            background: Container(
              child: PagedRecommendedInHome(),
            ),
          ),
        ),
        // SliverGrid(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       return Column(
        //         children: [
        //           PagedRecommendedInHome(),
        //           Container(
        //             child: Row(
        //               children: [
        //                 FlatButton(
        //                     onPressed: () {},
        //                     child: Column(
        //                       children: [
        //                         //Image
        //                         Text('Trade')
        //                       ],
        //                     ))
        //               ],
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //     childCount: 1,
        //   ),
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 200.0,
        //     mainAxisSpacing: 10.0,
        //     crossAxisSpacing: 10.0,
        //     childAspectRatio: 4.0,
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    // 3 Button
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              //Image
                              Text('Trade')
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              //Image
                              Text('Rent')
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              //Image

                              Text('Shop')
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //RENT
                  Container(
                    child: Column(
                      children: [
                        //RENT NEWS
                        Text('Berita Terbaru'),
                        FlatButton(
                          height: 200.0,
                          color: Colors.blue,
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('Big Recommended button'),
                            ],
                          ),
                        ),
                        FlatButton(
                          height: 40.0,
                          color: Colors.blue,
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  'Get voucher',
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                        ),
                        // FlatButton.icon(
                        //   height: 40.0,
                        //   color: Colors.blue,
                        //   onPressed: () {},
                        //   icon: Icon(Icons.arrow_forward),
                        //   label: Text('Get Voucher'),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    // RENT
                    //padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //TODO Harvest Rent recommended & special data
                        Text('Produk Spesial Rent'),
                        ScrollingItemCovers(
                          itemCovers: [
                            ItemsOnIt(
                              titling: 'Rent Special',
                            ),
                            ItemsOnIt(
                              titling: 'Rent Special2',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Rekomendasi Rent Untukmu'),
                        ScrollingItemCovers(
                          itemCovers: [
                            ItemsOnIt(
                              titling: 'Rent Recommended',
                            ),
                            ItemsOnIt(
                              titling: 'Rent Recommended2',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  //SHOP
                  Container(
                    width: 200.0,
                    height: 60.0,
                    color: Colors.orange,
                    child: FlatButton(
                      height: 200.0,
                      color: Colors.orange,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text('SHOP Coming Soon'),
                        ],
                      ),
                    ),
                  ),

                  // TRADE
                  Container(
                    child: Column(
                      children: [
                        //TODO Harvest Trade recommended & special data
                        Text('Produk Spesial Trade'),
                        ScrollingItemCovers(
                          itemCovers: [
                            ItemsOnIt(
                              titling: 'Trade Special',
                            ),
                            ItemsOnIt(
                              titling: 'Trade Special2',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Rekomendasi Trade Untukmu'),
                        ScrollingItemCovers(
                          itemCovers: [
                            ItemsOnIt(
                              titling: 'Trade Recommended',
                            ),
                            ItemsOnIt(
                              titling: 'Trade Recommended2',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
