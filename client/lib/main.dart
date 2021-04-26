import 'package:client/screens/home_screen.dart';
import 'package:client/state/book_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/book_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => BookState())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            BookDetails.routeName: (ctx) => BookDetails(),
          }),
    );
  }
}
