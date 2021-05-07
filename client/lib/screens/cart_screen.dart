import 'package:client/api/cart_api.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreens extends StatelessWidget {
  static const routeName = '/cart-screens';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null)
      return Scaffold(
        appBar: AppBar(
          title: Text("No Cart"),
        ),
        body: Center(
          child: Text("No Card Found"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("Cart Screens"),
          actions: [
            FlatButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                "${cart.cartbooks.length}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Total: ${cart.total}"),
                  Text("Date: ${cart.date}"),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: cart.cartbooks.length <= 0
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(OrderNew.routeName);
                          },
                    child: Text("Order"),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: cart.cartbooks.length <= 0
                        ? null
                        : () async {
                            bool isdelete = await Provider.of<CartState>(
                                    context,
                                    listen: false)
                                .deletecart(cart.id);
                            if (isdelete) {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName);
                            }
                          },
                    child: Text("Delate"),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartbooks.length,
                  itemBuilder: (ctx, i) {
                    var item = cart.cartbooks[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.book[0].title),
                                Text("Price : ${item.price}"),
                                Text("quantity : ${item.quantity}"),
                              ],
                            ),
                            RaisedButton(
                              color: Colors.greenAccent,
                              onPressed: () {
                                Provider.of<CartState>(context, listen: false)
                                    .deletecartbook(item.id);
                              },
                              child: Text("Delate"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
