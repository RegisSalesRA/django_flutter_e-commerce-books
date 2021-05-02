import 'dart:convert';
import 'package:client/models/cart_model.dart';
import 'package:client/models/order_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CartState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usetoken');
  //var token = storage.get('token');
  CartModel _cartModel;
  List<OrderModel> _orderder;

  Future<void> getCartDatas() async {
    String url = 'http://10.0.2.2:8000/api/v1/cart/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      print(data['error']);
      List<CartModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          CartModel cartModel = CartModel.fromJson(element);
          demo.add(cartModel);
        });
        _cartModel = demo[0];
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      print("error getCartDatas");
    }
  }

  Future<void> getoldOrders() async {
    String url = 'http://10.0.2.2:8000/api/v1/order/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      print(data['error']);
      List<CartModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          CartModel cartModel = CartModel.fromJson(element);
          demo.add(cartModel);
        });
        _cartModel = demo[0];
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      print("error getCartDatas");
    }
  }

  CartModel get cartModel {
    if (_cartModel != null) {
      return _cartModel;
    } else {
      return null;
    }
  }

  List<OrderModel> get oldorder {
    if (_orderder != null) {
      return [..._orderder];
    } else {
      return null;
    }
  }
}
