import 'package:client/screens/search_field.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/favorite_screen.dart';
import 'package:client/screens/home_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'account/login_screen.dart';
import 'account/register_screen.dart';
import 'api/book_api.dart';
import 'api/cart_api.dart';
import 'api/user_api.dart';
import 'screens/book_detail.dart';
import 'screens/cart_screen.dart';
import 'screens/order_history.dart';
import 'screens/order_screen.dart';

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
          //  theme: ThemeData(
          //    primaryColor: Color(0xFFFF6D00), accentColor: Color(0xFFFF6D00)),
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
            CartScreens.routeName: (ctx) => CartScreens(),
            OrderScreens.routeName: (ctx) => OrderScreens(),
            OrderNew.routeName: (ctx) => OrderNew(),
            SearchBook.routeName: (ctx) => SearchBook(),
          }),
    );
  }
}
