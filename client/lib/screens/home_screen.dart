import 'package:client/api/book_api.dart';
import 'package:client/api/cart_api.dart';
import 'package:client/screens/cart_screen.dart';
import 'package:client/screens/search_field.dart';
import 'package:client/widgets/drawer.dart';
import 'package:client/widgets/single_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screens';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _init = true;
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<CartState>(context).getCartDatas();
      Provider.of<CartState>(context).getoldOrders();
      _isLoading = await Provider.of<BookState>(context).getBooks();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    final book = Provider.of<BookState>(context).books;
    if (!_isLoading)
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Center(
          child: Text("No data yet"),
        ),
      );
    else
      return Container(
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
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage('assets/bookHome.jpg'),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(.4),
                                  Colors.black.withOpacity(.2),
                                ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Book is life",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 75),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87),
                              child: Center(
                                  child: Text(
                                "Search a book",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: GridView.builder(
                          itemCount: book.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 3,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, i) {
                            return SingleBook(
                              id: book[i].id,
                              title: book[i].title,
                              image: book[i].image,
                              favorite: book[i].favorite,
                            );
                          }),
                    ))
                  ],
                ),
              ),
            ),
          ));
  }
}
