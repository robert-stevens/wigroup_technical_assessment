// import 'package:flutter/material.dart';
// import 'package:test1/search_list.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Search',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch:Colors.yellow,
//         primaryColor: Color(0xFFFFBB54),
//         accentColor: Color(0xFFECEFF1),
//       ),
//       home: SearchList(),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/widgets/news_list.dart';
// import 'package:test1/widgets/news_list.dart';

void main() => runApp(App());


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      home: NewsList()
    );
  }

}