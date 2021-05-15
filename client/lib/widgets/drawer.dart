import 'package:client/account/login_screen.dart';
import 'package:client/screens/order_history.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/favorite_screen.dart';
import 'package:client/screens/home_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:client/api/user_api.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Guide Book App",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/booksLibrary.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.orange])),
            height: 490,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomListTile(
                        Icons.home,
                        'Home',
                        () => {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName)
                            }),
                    CustomListTile(
                        Icons.star,
                        'Favorites',
                        () => {
                              Navigator.of(context).pushReplacementNamed(
                                  FavoriteScreen.routeName)
                            }),
                    CustomListTile(
                        Icons.history,
                        'Orders History',
                        () => {
                              Navigator.of(context)
                                  .pushReplacementNamed(OrderScreens.routeName)
                            }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: CustomListTile(
                      Icons.logout, 'Logout', () => {_logoutnew()}),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
