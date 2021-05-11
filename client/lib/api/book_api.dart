import 'dart:convert';

import 'package:client/models/book_model.dart';
import 'package:client/service/api_adress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class SearchBooks {
  LocalStorage storage = new LocalStorage('usertoken');
  static Future<String> searchBook(String query) async {
    String url = '$baseUrl:8000/api/v1/books-filter/?search=$query';

    http.Response response = await http.get(url);

    return response.body;
  }
}

class BookState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');

  List<Book> _books = [];

  Future<bool> getBooks() async {
    String url = '$baseUrl:8000/api/v1/books/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Authorization': "token $token"
      });
      var data = json.decode(response.body) as List;
      //  print(data);
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
    String url = '$baseUrl:8000/api/v1/favorites/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(response.body);
      print(data);
      getBooks();
    } catch (e) {
      print("e favoriteButton");
      // print(e);
    }
  }

  List<Book> get books {
    return [..._books];
  }

  List<Book> get favorite {
    return _books.where((element) => element.favorite == true).toList();
  }

// Listando somente um livro route com id
  Book singleBook(int id) {
    return _books.firstWhere((element) => element.id == id);
  }
}
