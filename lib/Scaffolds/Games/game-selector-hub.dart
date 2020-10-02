import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/Scaffolds/Games/AnotherPageIndicatorDemo.dart';
import 'package:ourwearprototype/Scaffolds/Games/AttemptToCheckout.dart';
import 'package:ourwearprototype/Scaffolds/Games/CartScreen.dart';
import 'package:ourwearprototype/Scaffolds/Games/FakeAddToCart.dart';
import 'package:ourwearprototype/Scaffolds/Games/JustANothing.dart';
import 'package:ourwearprototype/Scaffolds/Games/JustLookRentalLists.dart';
import 'package:ourwearprototype/Scaffolds/Games/LoadingTest.dart';
import 'package:ourwearprototype/Scaffolds/Games/PageIndicatorImport/ArrowPageIndicator.dart';
import 'package:ourwearprototype/Scaffolds/Games/PageIndicatorImport/LinearProgressPageIndicator.dart';
import 'package:ourwearprototype/Scaffolds/Games/PageIndicatorImport/PageViewDemoImport.dart';
import 'package:ourwearprototype/Scaffolds/Games/PageIndicatorImport/StepPageIndicator.dart';
import 'package:ourwearprototype/Scaffolds/Games/PagedSwipe/PagedSwipeMother.dart';
import 'package:ourwearprototype/Scaffolds/Games/TabPageView.dart';
import 'package:ourwearprototype/Scaffolds/Games/WearerLists.dart';
//import 'package:ourwearprototype/shared/loading.dart';
//import 'package:ourwearprototype/shared/spareparts/CartItemListView.dart';

import 'ContainsScaffold.dart';
import 'Khochoc.dart';
import 'KhochocHighscore.dart';
import 'KhochocTimed.dart';
import 'RoffSkets.dart';
import 'ah-pusing.dart';
import 'flutter-box2D.dart';
import 'notFoundError.dart';

/*
* Game Selector
* Select Game!
*
* List of Tired to credit idk man:
* https://medium.com/flutter-community/games-in-flutter-flame-box2d-part-1-4c23a1cbc102
* https://medium.com/flutter-community/games-in-flutter-flame-box2d-part-2-142282a4856f
* https://medium.com/@suragch/a-complete-guide-to-flutters-listtile-597a20a3d449
* https://medium.com/flutter-community/flutter-listview-and-scrollphysics-a-detailed-look-7f0912df2754
* https://flutter.dev/docs/cookbook/design/drawer
* https://www.developerlibs.com/2019/09/flutter-drop-down-menu-list-example.html
* https://stackoverflow.com/q/50441168/9079640
* https://github.com/mkbreuer/view3d_snapset/releases
* https://stackoverflow.com/q/51679269/9079640
* https://jap.alekhin.io/setup-widget-tree-flame-flutter-game
 */

class GameHubScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Game!'),
        backgroundColor: Colors.green,
      ),
      body: GameList(),
    );
  }
}

class DaftarGame {
  const DaftarGame(this.ikon, this.nama);
  final IconData ikon;
  final String nama;
}

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  List<DaftarGame> daftarGame = [
    DaftarGame(Icons.check_box_outline_blank, 'Kotak ON/OFF'),
    DaftarGame(Icons.map, 'Maze Ball'),
    DaftarGame(Icons.error, 'Invoke 404 Not Found error Now!'),
    DaftarGame(Icons.all_inclusive, 'Achak Achak'),
    DaftarGame(Icons.vibration, 'Khochoc Khochoc!'),
    DaftarGame(Icons.vibration, 'Khochoc Timed!'),
    DaftarGame(Icons.score, 'Khochoc Highscore'),
    DaftarGame(Icons.redeem, 'OurWear Roff Skets'),
    DaftarGame(Icons.bubble_chart, 'Loading Screen'),
    DaftarGame(Icons.pageview, 'Page View sample'),
    DaftarGame(Icons.pageview, 'Demo of PageView Indicator'),
    DaftarGame(Icons.arrow_forward, 'Arrow PageView Indicator'),
    DaftarGame(Icons.linear_scale, 'Linear Progress Indicator'),
    DaftarGame(Icons.check_circle_outline, 'Step Page Indicator'),
    DaftarGame(Icons.pages, 'Another Page Indicator pubspec'),
    DaftarGame(Icons.tab, 'Tabbed Page View'),
    DaftarGame(Icons.nature, 'Rental List'),
    DaftarGame(Icons.add_shopping_cart, 'Fakely Add to shopping cart'),
    DaftarGame(Icons.credit_card, 'Attempt to checkout'),
    DaftarGame(Icons.shopping_cart, 'New Attempt Cart Screen'),
    DaftarGame(Icons.people, 'Wearers In Here'),
    DaftarGame(Icons.lightbulb_outline, 'Just A Nothing'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daftarGame.length,
      itemBuilder: (context, position) {
        return ListTile(
          onTap: () {
            Navigator.pop(context);
            // https://stackoverflow.com/questions/59766770/how-to-navigate-to-next-page-in-dynamic-list-view-flutter

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              switch (position) {
                case 0:
                  return containsScaffold();
                  break;
                case 1:
                  return MazeBallScaffold();
                  break;
                case 2:
                  return NotFoundError();
                  break;
                case 3:
                  return AchakAchak();
                  break;
                case 4:
                  return Khochoc();
                  break;
                case 5:
                  return KhochocTimed();
                  break;
                case 6:
                  return KhochocHighScore();
                  break;
                case 7:
                  return OurWearRoffSkets();
                  break;
                case 8:
                  return LoadingTest();
                  break;
                case 9:
                  return PagedSwipeScaffold();
                  break;
                case 10:
                  return PageViewDemo();
                  break;
                case 11:
                  return ArrowPageIndicatorDemo();
                  break;
                case 12:
                  return LinearProgressPageIndicatorDemo();
                  break;
                case 13:
                  return StepPageIndicatorDemo();
                  break;
                case 14:
                  return AnotherPageIndicatorDemo();
                  break;
                case 15:
                  return TabScaffold();
                  break;
                case 16:
                  return JustLookRentalLists();
                  break;
                case 17:
                  return FakeAddToCart();
                  break;
                case 18:
                  return CheckoutDoesNotWork();
                  break;
                case 19:
                  return CartScreen();
                  //return CartAhItDoesntWork();
                  break;
                case 20:
                  return WearerListsOfIt();
                  break;
                case 21:
                  return JustANothing();
                  break;
                default:
                  return NotFoundError();
                  break;
              }
            }));
          },
          title: Row(
            children: <Widget>[
              // https://api.flutter.dev/flutter/widgets/Icon-class.html
              // https://api.flutter.dev/flutter/material/Icons-class.html
              Icon(daftarGame[position].ikon),
              Text('${daftarGame[position].nama}')
            ],
          ),
        );
      },
    );
  }
}
