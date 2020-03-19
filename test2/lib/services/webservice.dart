import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Resource<T> {
  final String url; 
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class Webservice {

  Future<T> load<T>(Resource<T> resource, String params) async {
      print(resource.url+params);
      final response = await http.get(resource.url+params);
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to load data!');
      }
  }

}