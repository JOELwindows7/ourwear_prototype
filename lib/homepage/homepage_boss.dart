import 'package:flutter/material.dart';
import 'package:ourwearprototype/homepage/homepage_general.dart';
// https://flutter.dev/docs/cookbook/design/tabs
// https://medium.com/fluttervn/making-bottom-tabbar-with-flutter-5ff82e8defe0
// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
// https://flutter.dev/docs/cookbook/design/tabs
// https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb
/*
https://flutter.dev/docs/development/ui/advanced/slivers
https://flutter.dev/docs/development/ui/assets-and-images
https://flutter.dev/docs/cookbook/lists/horizontal-list
https://api.flutter.dev/flutter/material/SliverAppBar-class.html
https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html

*/
//JOELwindows7

class HomepageBoss extends StatefulWidget {
  @override
  _HomepageBossState createState() => _HomepageBossState();
}

class _HomepageBossState extends State<HomepageBoss> {
  int _selectedHomepage = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedHomepage = index;
    });
  }

  List<Widget> _homepageOptions = <Widget>[
    HomepageGeneral(),
    Container(
      child: Center(
        child: Text('B'),
      ),
    ),
    Container(
      child: Center(
        child: Text('C'),
      ),
    ),
    Container(
      child: Center(
        child: Text('D'),
      ),
    ),
    Container(
      child: Center(
        child: Text('E'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homepageOptions.elementAt(_selectedHomepage),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
          
        ],
        currentIndex: _selectedHomepage,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
