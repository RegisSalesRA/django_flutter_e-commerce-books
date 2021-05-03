import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UserState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');

  Future<bool> loginNow(String uname, String passw) async {
    String url = 'http://10.0.2.2:8000/api/v1/login/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            "username": uname,
            "password": passw,
          }));
      var data = json.decode(response.body) as Map;
      if (data.containsKey("token")) {
        storage.setItem("token", data['token']);

        return true;
      }
      return false;
    } catch (e) {
      print(" e login");
      print(e);
      return false;
    }
  }

  Future<bool> registerNow(String uname, String passw) async {
    String url = 'http://10.0.2.2:8000/api/v1/register/';
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            "username": uname,
            "password": passw,
          }));
      var data = json.decode(response.body) as Map;
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print(" e login");
      print(e);
      return false;
    }
  }
}
