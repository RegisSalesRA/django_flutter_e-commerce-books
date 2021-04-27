import 'dart:convert';

import 'package:client/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookState with ChangeNotifier {
  List<Book> _books = [];

  Future<bool> getBooks() async {
    String url = 'http://10.0.2.2:8000/api/v1/books/';
    try {
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Authorization': "token a2b6c5549193a6bc0e9f42ba1ad559cc1e31c33e"
      });
      var data = json.decode(response.body) as List;
      print(data);
      List<Book> temp = [];
      data.forEach((element) {
        Book book = Book.fromJson(element);
        temp.add(book);
      });
      _books = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> favoriteButton(int id) async {
    String url = 'http://10.0.2.2:8000/api/v1/favorite/';

    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token a2b6c5549193a6bc0e9f42ba1ad559cc1e31c33e"
          });
      var data = json.decode(response.body);
      print(data);
      getBooks();
    } catch (e) {
      print("e favoriteButton");
      print(e);
    }
  }

  List<Book> get book {
    return [..._books];
  }

// Listando somente um livro route com id
  Book singleBook(int id) {
    return _books.firstWhere((element) => element.id == id);
  }
}
