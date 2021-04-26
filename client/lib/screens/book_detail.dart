import 'package:client/state/book_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  static const routeName = '/product-details-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final book = Provider.of<BookState>(context).singleBook(id);
    return Scaffold(
      appBar: AppBar(title: Text("Book Details")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Text(book.title),
      ),
    );
  }
}
