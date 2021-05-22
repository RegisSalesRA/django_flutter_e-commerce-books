import 'package:client/api/cart_api.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/screens/order_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderNew extends StatefulWidget {
  static const routeName = '/order-now-screens';
  @override
  _OrderNewState createState() => _OrderNewState();
}

class _OrderNewState extends State<OrderNew> {
  bool _init = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<CartState>(context).getCartDatas();
      Provider.of<CartState>(context).getoldOrders();
      Provider.of<CartState>(context).cartModel;
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  final _form = GlobalKey<FormState>();
  String _email = '';
  String _phone = '';
  String _address = '';
  void _orderNew() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    final cart = Provider.of<CartState>(context, listen: false).cartModel;
    bool order = await Provider.of<CartState>(context, listen: false)
        .ordercart(cart.id, _address, _email, _phone);
    if (order) {
      Navigator.of(context).pushNamed(OrderScreens.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text("Order Now!!"),
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
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _form,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: "Email"),
                                  validator: (v) {
                                    if (v.isEmpty) {
                                      return "Enter Your Email";
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _email = v;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: "Phone"),
                                  validator: (v) {
                                    if (v.isEmpty) {
                                      return "Enter Your Phone Number";
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _phone = v;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: "Address"),
                                  validator: (v) {
                                    if (v.isEmpty) {
                                      return "Enter Your Address";
                                    }
                                    return null;
                                  },
                                  onSaved: (v) {
                                    _address = v;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    _orderNew();
                                  },
                                  child: Text("Order"),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(CartScreens.routeName);
                                  },
                                  child: Text("Edit Cart"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )));
  }
}


/*

Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter Your Email";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _email = v;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Phone"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter Your Phone Number";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _phone = v;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Address"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter Your Address";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _address = v;
                    },
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          _orderNew();
                        },
                        child: Text("Order"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreens.routeName);
                        },
                        child: Text("Edit Cart"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

*/