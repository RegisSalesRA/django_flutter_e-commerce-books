import 'package:client/api/book_api.dart';
import 'package:client/api/cart_api.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/widgets/drawer.dart';
import 'package:client/widgets/single_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite-screens';
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<BookState>(context).favorite;
    final cart = Provider.of<CartState>(context).cartModel;
    return Scaffold(
        drawer: AppDrawer(),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.grey, Colors.orangeAccent]),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              drawer: AppDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text("Favorites!!"),
                actions: [
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreens.routeName);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    label: Text(
                      cart != null ? "${cart.cartbooks.length}" : '',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 3,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: favorite.length,
                          itemBuilder: (ctx, i) => SingleBook(
                            id: favorite[i].id,
                            title: favorite[i].title,
                            image: favorite[i].image,
                            favorite: favorite[i].favorite,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
