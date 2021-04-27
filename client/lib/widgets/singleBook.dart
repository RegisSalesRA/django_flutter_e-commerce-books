import 'package:client/screens/book_detail.dart';
import 'package:client/state/book_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleBook extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favorite;

  const SingleBook({Key key, this.id, this.title, this.image, this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            BookDetails.routeName,
            arguments: id,
          );
        },
        child: Image.network(
          "http://10.0.2.2:8000$image",
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title),
        leading: IconButton(
          onPressed: () {
            Provider.of<BookState>(context, listen: false).favoriteButton(id);
          },
          icon: Icon(
            favorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
