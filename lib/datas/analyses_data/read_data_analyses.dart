import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class AnalysesReader {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  Future<File> get _localFile async {
    final path = join(await _localPath, 'analyses.json');
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
      print('Analyses data read error: $e');
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


  Future<Map<String, dynamic>?> getDaysSet() async {
    //todo gün masa rawlı
    return null;
  }


  Future<double> getDaysTotalRevenue(DateTime targetDate) async {
    return -1.0;
  }


  Future<void> writeJsonData(String jsonData) async {
    final file = await _localFile;
    try {
      await file.writeAsString(jsonData);
    } catch (e) {
      print('JSON data write error: $e');
    }
  }
}
