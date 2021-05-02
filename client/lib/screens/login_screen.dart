import 'package:client/screens/home_screen.dart';
import 'package:client/screens/register_screen.dart';
import 'package:client/state/user_state.dart';
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
      appBar: AppBar(
        title: Text("Login Now"),
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
                        _loginNew();
                      },
                      child: Text("login"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: Text("Register"),
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
