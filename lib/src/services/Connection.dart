import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Connection{

  static String _userUrl = 'http://192.168.25.221:3001/api/user/';
  static String _productUrl = 'http://192.168.25.221:3001/api/products/';

  static Future<http.Response> getUser(String id){
    return http.get(_userUrl + id);
  }

  static Future<http.Response> postUser(String userJson){
    return http.post(_userUrl, headers: {'Content-Type': "application/json"}, body: userJson);
  }

  static Future<http.Response> logIn(String userName, String password){
    return http.post(_userUrl + 'login', headers: {'Content-Type': "application/json"},
      body: jsonEncode({'email': userName, 'password': password}));
  }

  static Future<http.Response> loginFacebook(String userJson){
    return http.post(_userUrl + 'login-facebook', headers: {'Content-Type': "application/json"},
      body: userJson);
  }

  static Future<http.Response> editUser(String id, String userJson){
    return http.put(_userUrl + id, headers: {'Content-Type': "application/json"},
    body: userJson);
  }

  //producst
  static Future<http.Response> getProducts(){
    return http.get(_productUrl);
  }
}