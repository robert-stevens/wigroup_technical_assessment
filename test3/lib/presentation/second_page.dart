import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Second Screen'),
          ),
          body: Container(
            padding: const EdgeInsets.all(23.2),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Second screen',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
