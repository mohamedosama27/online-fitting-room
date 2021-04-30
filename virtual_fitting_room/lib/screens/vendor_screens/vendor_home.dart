import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/login.dart';
import 'package:virtual_fitting_room/screens/notifications.dart';
import 'package:virtual_fitting_room/screens/my_account.dart';
import 'package:virtual_fitting_room/screens/vendor_screens/vender_brands.dart';

class vendorHome extends StatefulWidget {
  vendorHome({Key key}) : super(key: key);

  @override
  _vendorHomeScreenState createState() => _vendorHomeScreenState();
}
class _vendorHomeScreenState extends State<vendorHome> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget body() {
    switch(_selectedIndex) {
      case 0:
        return Brands();
        break;
      case 1:
        return Notifications();
        break;
      case 2:
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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)
                      =>
                          login()
                  ));
            },
          ),
          centerTitle: true,
          title: Center(
              child: Text("Virtual Fitting Room",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25))),
          actions: <Widget>[
            Container()
           ]
      ),
      body: Center(
        child: body(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
         
          BottomNavigationBarItem(
            icon: Icon(Icons.dry_cleaning),
            label: 'Brands',
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