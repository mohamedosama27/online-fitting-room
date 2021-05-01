import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/auth.dart';
import 'package:virtual_fitting_room/screens/cart.dart';
import 'package:virtual_fitting_room/screens/clothes.dart';
import 'package:virtual_fitting_room/screens/home_page.dart';
import 'package:virtual_fitting_room/screens/login.dart';
import 'package:virtual_fitting_room/screens/my_account.dart';
import 'package:virtual_fitting_room/screens/notifications.dart';

import 'images_screen.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget body() {
    switch (_selectedIndex) {
      case 0:
        return HomePage();
        break;
      case 1:
        return Clothes();
        break;
      case 2:
        return ImagesScreen(); //bdal el notification
        break;
      case 3:
        return myAccount();
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void showMoreButton() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF9F140B),
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => login()));
            },
          ),
          title: Center(
              child: Text("Virtual Fitting Room",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25))),
          actions: <Widget>[
            IconButton(
              icon: new Stack(children: <Widget>[
                new Icon(Icons.shopping_cart),
                new Positioned(
                  // draw a red marble
                  top: 0.0,
                  right: 0.0,
                  child: new Icon(Icons.brightness_1,
                      size: 8.0, color: Colors.redAccent),
                )
              ]),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
            )
          ]),
      body: Center(
        child: body(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dry_cleaning),
            label: 'Clothes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF9F140B),
        onTap: _onItemTapped,
      ),
    );
  }
}
