import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    'OPEN PROTECTED',
                    style: TextStyle(color: Colors.black),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/protected');
                  },
                ))
          ],
        )),
      ),
    );
  }
}
