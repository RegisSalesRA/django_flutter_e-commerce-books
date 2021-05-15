import 'dart:ui';

import 'package:client/account/register_screen.dart';
import 'package:client/api/user_api.dart';
import 'package:client/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';
  final _form = GlobalKey<FormState>();

  void _loginNew() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool istoken = await Provider.of<UserState>(
      context,
      listen: false,
    ).loginNow(_username, _password);
    if (istoken) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Algo errado"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/livrologin.webp"),
                    fit: BoxFit.cover)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(),
                SingleChildScrollView(
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 150),
                          child: Text(""),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (v) {
                              if (v.isEmpty) {
                                return "Enter your username";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                ),
                                hintText: "Username",
                                filled: true,
                                hintStyle: (TextStyle(
                                    color: Colors.white, fontSize: 20)),
                                border: InputBorder.none),
                            onSaved: (v) {
                              _username = v;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25, top: 20),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (v) {
                              if (v.isEmpty) {
                                return "Enter your password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                ),
                                hintText: "Password",
                                hintStyle: (TextStyle(
                                    color: Colors.white, fontSize: 20)),
                                filled: true,
                                border: InputBorder.none),
                            onSaved: (v) {
                              _password = v;
                            },
                            obscureText: true,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 55),
                              child: Text(""),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  _loginNew();
                                },
                                child: Container(
                                  width: 200,
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.red, Colors.orange]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //BOTAO CADASTRE
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    RegisterScreen.routeName);
                              },
                              child: Text(
                                "clique aqui para se cadastrar",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
