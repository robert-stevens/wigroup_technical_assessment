import 'package:flutter/material.dart';
import 'package:reduxauth/config/app_config.dart' as config;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final SharedPreferences prefs;
  HomePage({this.prefs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(23.2),
          child: Column(
            children: <Widget>[
              const Text('Home page....'),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  child: Text(
                    'OPEN SECOND',
                    style: TextStyle(color: Colors.black),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                )),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.black),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  onPressed: () {
                    prefs.remove('token');
                    Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                  },
                ))
            ],
          )
        ),
      );
  }
}
