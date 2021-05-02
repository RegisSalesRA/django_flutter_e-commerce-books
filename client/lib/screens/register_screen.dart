import 'package:client/screens/login_screen.dart';
import 'package:client/state/user_state.dart';
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
        title: Text("Register your Account"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter your username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  onSaved: (v) {
                    _username = v;
                  },
                ),
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter your password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
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
                TextFormField(
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
                    hintText: "Confirme Password",
                  ),
                  onSaved: (v) {
                    _password = v;
                  },
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _registerNow();
                      },
                      child: Text("Register"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        "Login New",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
