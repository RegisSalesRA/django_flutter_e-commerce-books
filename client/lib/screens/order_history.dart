import 'package:client/api/cart_api.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreens extends StatelessWidget {
  static const routeName = '/order-screens';
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).oldorder;
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
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.all(15),
                  child: Column(children: <Widget>[
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
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx, i) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      data[i].email,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      data[i].phone,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      data[i].address,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Total : ${data[i].cart.total}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )));
  }
}
