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
          // _searchText = '';
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          // _searchText = _searchQuery.text;
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
  // String _searchText = '';
  List<dynamic> _newsArticles = List<dynamic>(); 

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    _populateNewsArticles(); 
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all, 'search=bears').then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });
  }

  void _getNewsArticles(String text) {
    Webservice().load(NewsArticle.all, 'search=$text').then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
      return ListTile(
        title: Text(_newsArticles[index], style: const TextStyle(fontSize: 18)),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (BuildContext context) {
            return WebViewWebPage(title: _newsArticles[index], url: 'https://en.wikipedia.org/wiki/${Uri.encodeComponent(_newsArticles[index])}');
          }));
        },
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