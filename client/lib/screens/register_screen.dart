import 'package:client/api/user_api.dart';
import 'package:client/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  String _confpassword = '';

  void _registerNow() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool isregister = await Provider.of<UserState>(
      context,
      listen: false,
    ).registerNow(_username, _password);
    if (isregister) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Algo errado"),
              actions: [
                // ignore: deprecated_member_use
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
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }),
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
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
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
                                  hintStyle: (TextStyle(
                                      color: Colors.white, fontSize: 20)),
                                  filled: true,
                                  border: InputBorder.none),
                              onSaved: (v) {
                                _username = v;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
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
                              onChanged: (v) {
                                setState(() {
                                  _confpassword = v;
                                });
                              },
                              onSaved: (v) {
                                _password = v;
                              },
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: (v) {
                                if (_confpassword != v) {
                                  return "Confirm dont match";
                                }
                                if (v.isEmpty) {
                                  return "Confirm your password";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                  ),
                                  hintText: "Confirm Password",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Text(""),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: InkWell(
                                      onTap: () {
                                        _registerNow();
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 60,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.red,
                                              Colors.orange
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
