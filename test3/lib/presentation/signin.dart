import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/model.dart';
import '../utils/index.dart';

typedef OnSaveCallback = Function(String email, String password, BuildContext context);

class LoginScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final Login login;

  LoginScreen({Key key, @required this.onSave, @required this.login});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  void handleChange(String name, String value) {
    if (name == 'email') {
      setState(() {
        email = value;
      });
    }
    if (name == 'password') {
      setState(() {
        password = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: const EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2), offset: const Offset(0, 10), blurRadius: 20)
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 25),
                        Text('Sign In', style: Theme.of(context).textTheme.display2),
                        const SizedBox(height: 20),
                        FormEmailField(
                          handleChange: handleChange,
                        ),
                        const SizedBox(height: 20),
                        FormPasswordField(
                          handleChange: handleChange,
                        ),
                        const SizedBox(height: 30),
                        FlatButton(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                          onPressed: widget.login.loading ? null : () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              widget.onSave(email, password, context);
                            }
                          },
                          child: Text(
                            widget.login.loading ? 'Loading': 'Login',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: const StadiumBorder(),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
typedef OnChangeCallback = Function(String name, String value);

class FormEmailField extends StatefulWidget {
  const FormEmailField({Key key, this.handleChange}) : super(key: key);

  final OnChangeCallback handleChange;

  _FormEmailFieldState createState() => _FormEmailFieldState();
}

class _FormEmailFieldState extends State<FormEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Theme.of(context).focusColor),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email Address',
          hintStyle: Theme.of(context).textTheme.body1.merge(
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.6)),
              ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
          prefixIcon: Icon(
            Icons.mail,
            color: Theme.of(context).focusColor.withOpacity(0.6),
          ),
        ),
        onSaved: (String val) {
          widget.handleChange('email', val);
        },
        validator: (String value) {
          return value.trim().isEmpty ? 'Email is required' : null;
        },
      );
  }
}

class FormPasswordField extends StatefulWidget {
  const FormPasswordField({Key key, this.handleChange}) : super(key: key);

  final OnChangeCallback handleChange;

  _FormPasswordField createState() => _FormPasswordField();
}

class _FormPasswordField extends State<FormPasswordField> {

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Theme.of(context).focusColor),
        keyboardType: TextInputType.text,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: Theme.of(context).textTheme.body1.merge(
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.6)),
              ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).focusColor.withOpacity(0.6),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            color: Theme.of(context).focusColor.withOpacity(0.4),
            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        validator: (String value) {
          return value.trim().isEmpty
              ? 'Password field is required'
              : null;
        },
        onSaved: (String val) {
          widget.handleChange('password', val);
        },
      );
  }
}
