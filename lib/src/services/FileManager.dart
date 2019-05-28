import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager{
  
  static Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/user.json');
  }

  static Future<File> writeUser(String user) async{
    final file = await _localFile;
    return file.writeAsString('$user');
  }

  static Future<String> readUser() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

}