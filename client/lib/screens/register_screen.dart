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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register your account"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
              key: _form,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.app_registration,
                        color: Colors.blueAccent,
                        size: 150,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Enter your username";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Username",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))),
                        onSaved: (v) {
                          _username = v;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Enter your password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))),
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
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Confirm Password",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))),
                        onSaved: (v) {
                          _password = v;
                        },
                        obscureText: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {
                            _registerNow();
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Colors.blue,
                          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            "Login New",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Colors.blue,
                          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
