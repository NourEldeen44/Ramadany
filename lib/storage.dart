
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    // final abs= file.writeAsString('$data');
    print(data);
    return file.writeAsString("$data");
  }
  Future<bool>saveBool(String key, bool boolean)async{
    final pref = await SharedPreferences.getInstance();
   return pref.setBool(key, boolean);
  }
  Future<bool>getBool(String key)async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }
  Future<bool>setInt(String key,int count)async{
   final pref = await SharedPreferences.getInstance();
   return pref.setInt(key, count);
  }
  Future<int>getInt(String key)async{
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
   Future<File> loadFile (String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final name = basename(path);
    final dir = await getApplicationDocumentsDirectory();
    File file;
    //if file already exists
    if (File('${dir.path}/$name').existsSync()) {
      file = File('${dir.path}/$name');
    }
    //if first time to app then must buffer data & write file
    else{
  file = File('${dir.path}/$name');
  await file.writeAsBytes(bytes,flush: true);
    }
    return file;
  }
}