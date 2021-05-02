import 'package:client/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null)
      return Scaffold(
        appBar: AppBar(
          title: Text("no cart"),
        ),
        body: Center(
          child: Text("No cart"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("Cart Screen"),
          actions: [
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text("${cart}"),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [Text('total 0')],
              )
            ],
          ),
        ),
      );
  }
}
