import 'dart:async';
import 'package:http/http.dart' as http;

class Connection{

  static String _userUrl = 'http://192.168.25.221:3001/api/user/';
  static String _productUrl = 'http://192.168.25.221:3001/api/products/';

  static Future<http.Response> getUser(String id){
    return http.get(_userUrl + id);
  }

  static Future<http.Response> postUser(String userJson){
    print(userJson);
    return http.post(_userUrl, headers: {'Content-Type': "application/json"}, body: userJson);
  }
}