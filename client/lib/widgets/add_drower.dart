import 'package:client/screens/order_history_screen.dart';
import 'package:client/screens/order_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/favorite_screen.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/login_screen.dart';
import 'package:localstorage/localstorage.dart';

class AppDrown extends StatefulWidget {
  @override
  _AppDrownState createState() => _AppDrownState();
}

class _AppDrownState extends State<AppDrown> {
  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Welcome"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            trailing: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FavoriteScreen.routeName);
            },
            trailing: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text("Favorite"),
          ),
          ListTile(
            onTap: () {
              print(Text("Funcionando"));
              Navigator.of(context)
                  .pushReplacementNamed(OrderScreens.routeName);
            },
            trailing: Icon(
              Icons.history,
              color: Colors.blue,
            ),
            title: Text("Old Orders"),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              _logoutnew();
            },
            trailing: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
//OrderScreens