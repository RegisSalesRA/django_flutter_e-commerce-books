import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:client/api/book_api.dart';
import 'dart:convert';

class SearchBook extends StatefulWidget {
  @override
  _SearchBookState createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  List<dynamic> searchResults = [];

  searchBookData(value) async {
    SearchBooks.searchBook(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((value) {
          searchResults.add(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                onChanged: (val) {
                  searchResults.clear();
                  searchBookData(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  hintText: 'Search for book',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                )),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              return buildResultCard(searchResults[index]);
            },
          ),
        ],
      )),
    );
  }
}

Widget buildResultCard(data) {
  print(data);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(data['title']),
        ),
        Divider(color: Colors.black)
      ],
    ),
  );
}
