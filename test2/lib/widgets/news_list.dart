import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/models/news_article.dart';
import 'package:test1/services/webservice.dart';
import 'package:test1/screens/open_wiki.dart';

class NewsList extends StatefulWidget {
  const NewsList({ Key key }) : super(key: key);
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  _NewsListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _getNewsArticles(_searchQuery.text);
        });
      }
    });
  }

  Widget appBarTitle = Text('Wikipedia Example', style: TextStyle(color: Colors.white),);
  Icon actionIcon = Icon(Icons.search, color: Colors.white,);
  final GlobalKey key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<String> _list;
  bool _IsSearching;
  List<NewsArticle> _newsArticles = List<NewsArticle>(); 
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    myFocusNode = FocusNode();
    _getRandomArticles(); 
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  void _getRandomArticles() {
    Webservice().load(NewsArticle.random, '').then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });
  }

  void _getNewsArticles(String text) {
    Webservice().load(NewsArticle.all, text).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });
  }

  Card _buildItemsForListView(BuildContext context, int index) {
      return Card(child:
        ListTile(
          title: Text(_newsArticles[index].title, style: const TextStyle(fontSize: 18)),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return WebViewWebPage(title: _newsArticles[index].title, url: 'https://en.wikipedia.org/wiki/${Uri.encodeComponent(_newsArticles[index].title)}');
            }));
          },
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: ListView.builder(
          itemCount: _newsArticles.length,
          itemBuilder: _buildItemsForListView,
        )
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
                  focusNode: myFocusNode,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Search Wikipedia...',
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
    myFocusNode.requestFocus(); //setting focus to search field
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = Icon(Icons.search, color: Colors.white,);
      appBarTitle =
      Text('Wikipedia Example', style: TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}