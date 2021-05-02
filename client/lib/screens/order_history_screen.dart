import 'package:client/state/cart_state.dart';
import 'package:client/widgets/add_drower.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreens extends StatelessWidget {
  static const routeName = '/order-screens';
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).oldorder;
    return Scaffold(
      appBar: AppBar(
        title: Text("Old Orders"),
      ),
      drawer: AppDrown(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(data[i].email),
                    Text(data[i].phone),
                    Text(data[i].address),
                    Text("Total : ${data[i].cart.total}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
