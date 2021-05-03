import 'package:client/api/user_api.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/register_screen.dart';
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
        title: Text("Login Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                ),
                Padding(
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
                    padding: EdgeInsets.all(15)),
                Padding(
                  padding: EdgeInsets.all(16),
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
                    onSaved: (v) {
                      _password = v;
                    },
                    obscureText: true,
                  ),
                ),
                // botoes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        _loginNew();
                      },
                      child: Text(
                        "login",
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
                            .pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
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
