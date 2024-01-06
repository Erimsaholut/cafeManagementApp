import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReadNewData {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/menu.json');
  }

  Future<void> writeCounter(String jsonFile) async {
    final file = await _localFile;
    await file.writeAsString(jsonFile);
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          if (jsonData.containsKey("cafe_name")) {
            return jsonData["cafe_name"];
          }
        }
      }
    } catch (e) {
      print('Error reading counter: $e');
    }
    return ""; // Varsayılan değer
  }
}
