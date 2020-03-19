import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProtectedScreen extends StatelessWidget {
  final SharedPreferences prefs;
  ProtectedScreen({this.prefs});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Protected Screen'),
          ),
          body: Container(
            padding: const EdgeInsets.all(23.2),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Protected screen',
                    style: TextStyle(color: Colors.black),
                  ),
                  OutlineButton(
                    onPressed: () {
                      prefs.remove('token');
                      Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                    },
                    child: const Text('Logout'),
                  )
                ],
              ),
            ),
          ),
        );
  }
}
