import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:validators/validators.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _loadUrl(_searchQuery.text);
        });
      }
    });
  }

  Widget appBarTitle = Text('WebView Example', style: TextStyle(color: Colors.white),);
  Icon actionIcon = Icon(Icons.search, color: Colors.white,);
  final GlobalKey key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  String url;
  bool _IsSearching;
  WebViewController _controllerWeb;

  @override
  void initState() {

    super.initState();
    url = 'https://www.wigroupinternational.com/';
  }

  void _loadUrl(String text) {
    if(isURL(text)){
      setState(() {                
        _controllerWeb.loadUrl(text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: buildBar(context),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerWeb = webViewController;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                actionIcon = Icon(Icons.close, color: Colors.white,);
                appBarTitle = TextField(
                  controller: _searchQuery,
                  style: TextStyle(
                    color: Colors.white,

                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Enter Valid URL...',
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = Icon(Icons.search, color: Colors.white,);
      appBarTitle =
      Text('WebView Example', style: TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}
