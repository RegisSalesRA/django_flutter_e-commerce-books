import 'package:client/screens/order_history_screen.dart';
import 'package:client/screens/order_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/screens/favorite_screen.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/login_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/state/book_state.dart';
import 'package:client/state/cart_state.dart';
import 'package:client/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'screens/book_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => BookState()),
        ChangeNotifierProvider(create: (ctx) => UserState()),
        ChangeNotifierProvider(create: (ctx) => CartState()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (storage.getItem('token') == null) {
                return LoginScreen();
              }
              return HomeScreen();
            },
          ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            BookDetails.routeName: (ctx) => BookDetails(),
            FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreens.routeName: (ctx) => OrderScreens(),
          }),
    );
  }
}
