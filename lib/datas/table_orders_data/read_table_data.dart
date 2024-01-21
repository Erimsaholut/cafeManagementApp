import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TableDataHandler {
  final int tableNum = 1;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = join(await _localPath, 'tableOrderData.json');
    return File(path);
  }

  Future<Map<String, dynamic>?> readJsonData() async {
    try {
      final file = await _localFile;

      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          return jsonDecode(content);
        }
      }
    } catch (e) {
      print('Table data read error: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getRawData() async {
    try {
      return await readJsonData();
    } catch (e) {
      print('Raw data read error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTableSet(int tableNum) async {
    try {
      Map<String, dynamic>? rawData = await getRawData();
      if (rawData != null) {
        List<Map<String, dynamic>> tables = List<Map<String, dynamic>>.from(rawData["tables"]);
        for (var table in tables) {
          if (table["tableNum"] == tableNum) {
            return Future.value(table);
          }
        }
      }
    } catch (e) {
      print('Raw data read error: $e');
      return null;
    }
    return null;
  }

  Future<void> writeJsonData(String jsonData) async {
    final file = await _localFile;
    try {
      await file.writeAsString(jsonData);
      print("Table $tableNum data updated successfully.");
    } catch (e) {
      print('JSON data write error: $e');
    }
  }
}
