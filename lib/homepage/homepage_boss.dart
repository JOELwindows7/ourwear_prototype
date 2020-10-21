import 'package:flutter/material.dart';
import 'package:ourwearprototype/homepage/homepage_general.dart';
// https://flutter.dev/docs/cookbook/design/tabs
// https://medium.com/fluttervn/making-bottom-tabbar-with-flutter-5ff82e8defe0
// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
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

  List<Widget> _homepageOptions = <Widget>[HomepageGeneral()];

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
            icon: Icon(Icons.shopping_bag),
            label: 'My Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedHomepage,
        selectedItemColor: Colors.redAccent[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
