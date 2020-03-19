import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/widgets/news_list.dart';

void main() => runApp(App());


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Networking',
      debugShowCheckedModeBanner: false,
      home: NewsList()
    );
  }

}