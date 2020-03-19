import 'dart:convert';
import 'package:test1/services/webservice.dart';
import 'package:test1/utils/constants.dart';
import 'package:http/http.dart' as http;

class NewsArticle {
  
  final String title; 

  NewsArticle({this.title});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      title: json['title'], 
    );
  }

  static Resource<List<NewsArticle>> get all {
    
    return Resource(
      url: Constants.WIKIPEDIA_URL,
      parse: ( http.Response response) {
        final dynamic result = json.decode(response.body); 
        Iterable list = result['query']['search'];
        return list.map((dynamic model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

  static Resource<List<NewsArticle>> get random {
    
    return Resource(
      url: Constants.WIKI_RANDOM_URL,
      parse: ( http.Response response) {
        final dynamic result = json.decode(response.body); 
        Iterable list = result['query']['random'];
        return list.map((dynamic model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

}