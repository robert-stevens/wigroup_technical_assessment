import 'dart:convert';
import 'package:test1/services/webservice.dart';
import 'package:test1/utils/constants.dart';
import 'package:http/http.dart' as http;

class NewsArticle {
  
  final String title; 
  // final String descrption; 
  // final String urlToImage; 

  NewsArticle({this.title});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    print('json: $json');
    return NewsArticle(
      title: json['title'], 
      // descrption: json['description'], 
      // urlToImage: json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL
    );
  }

  static Resource<List<dynamic>> get all {
    
    return Resource(
      url: Constants.WIKIPEDIA_URL,
      parse: ( http.Response response) {
        // print('response: ${response.body}');
        final dynamic result = json.decode(response.body); 
        print(result[1]);
        Iterable list = result[1];
        return list;
        // return list.map((dynamic model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

}