import 'package:client/state/book_state.dart';
import 'package:client/widgets/add_drower.dart';
import 'package:client/widgets/singleBook.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite-screens';
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<BookState>(context).favorite;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      drawer: AppDrown(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
