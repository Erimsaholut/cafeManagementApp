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

  Future<Map<String, dynamic>?> getRawData() async {
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

  Future<Map<String, dynamic>?> getDaySet(int day, int month, int year) async {
    String date = "$day.$month.$year";
    Map<String, dynamic>? rawData = await getRawData();

    if (rawData != null && rawData.containsKey("sales")) {
      Map<String, dynamic> salesData = rawData["sales"];
      if (salesData.containsKey(date)) {
        return salesData[date];
      } else {
        print("Belirtilen tarihe ait satış verisi bulunamadı.");
        return null;
      }
    } else {
      print("Satış verileri bulunamadı veya işlenemedi.");
      return null;
    }
  }

  Future<double> getDaysTotalRevenue(int day, int month, int year) async {
    double totalRevenue = 0.0;
    Map<String, dynamic>? daySet = await getDaySet(day, month, year);

    if (daySet != null && daySet.containsKey("products")) {
      Map<String, dynamic> products = daySet["products"];
      products.forEach((key, value) {
        totalRevenue += value["revenue"];
      });
      return totalRevenue;
    } else {
      print("Belirtilen tarihe ait satış verisi bulunamadı veya işlenemedi.");
      return -1.0;
    }
  }


  Future<void> writeJsonData(String jsonData) async {
    final file = await _localFile;
    try {
      await file.writeAsString(jsonData);
      print("Başarılı");
    } catch (e) {
      print('JSON data write error: $e');
    }
  }
}
