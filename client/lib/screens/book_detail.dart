import 'dart:math';

import 'package:client/api/book_api.dart';
import 'package:client/api/cart_api.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/service/api_adress.dart';
import 'package:client/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  static const routeName = '/product-details-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final book = Provider.of<BookState>(context).singleBook(id);
    final cart = Provider.of<CartState>(context).cartModel;

    return Scaffold(
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
            title: Text("Welcome!!"),
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
                child: Column(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ])),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          Image.network(
                            "$baseUrl:8000${book.image}",
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(40),
                                  )),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Market Price : \$${book.marcketPrice.toString()}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "Selling Price : \$${book.sellingPrice.toString()}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      // ignore: deprecated_member_use
                                      RaisedButton.icon(
                                        color: Colors.orangeAccent,
                                        onPressed: () {
                                          Provider.of<CartState>(context,
                                                  listen: false)
                                              .addtoCart(id);
                                        },
                                        icon: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "Add to cart",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      book.description,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ])),
          ),
        ),
      ),
    );
  }
}
