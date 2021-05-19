import 'package:client/api/book_api.dart';
import 'package:client/screens/book_detail.dart';
import 'package:client/service/api_adress.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                BookDetails.routeName,
                arguments: id,
              );
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "$baseUrl:8000$image",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 44,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: GridTileBar(
              title: Text(title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              leading: IconButton(
                onPressed: () {
                  Provider.of<BookState>(context, listen: false)
                      .favoriteButton(id);
                },
                icon: Icon(
                  favorite ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                ),
              ),
            ),
          )),
    );
  }
}
