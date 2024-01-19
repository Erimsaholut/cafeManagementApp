import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';


class TableDataHandler {
  int tableNum;

  TableDataHandler(this.tableNum);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tableOrderData$tableNum.json');
  }

  Future<void> initializeTableData() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        // Masa dosyası yoksa, yeni bir dosya oluştur
        await writeJsonData('{"tableNum": $tableNum, "totalPrice": 0, "orders": []}');
        print("Table $tableNum data initialized successfully.");
      } else {
        print("Table $tableNum data file already exists.");
      }
    } catch (e) {
      print('Table data initialization error: $e');
    }
  }

  Future<void> updateTableData(List<dynamic> orders) async {
    try {
      Map<String, dynamic>? jsonData = await readJsonData();
      if (jsonData != null) {
        var tableToUpdate = jsonData['tables'].firstWhere(
              (table) => table['tableNum'] == tableNum,
          orElse: () => null,
        );

        if (tableToUpdate != null) {
          tableToUpdate['orders'] = orders;

          int totalPrice = orders.fold<int>(0, (int sum, order) => sum + (order['price'] * order['quantity']) as int);

          tableToUpdate['totalPrice'] = totalPrice;

          await writeJsonData(jsonEncode(jsonData));
          print("Table $tableNum data updated successfully.");
        } else {
          print("Table $tableNum not found.");
        }
      }
    } catch (e) {
      print('Table data update error: $e');
    }
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

  Future<Map<String, dynamic>?> readJsonData() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          return jsonData;
        } else {
          print('Table $tableNum data file is empty.');
        }
      } else {
        print('Table $tableNum data file does not exist.');
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
}
