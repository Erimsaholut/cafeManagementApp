import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ReadJson {
  List<dynamic> _items = [];
  String cafeName = "Cafe";
  int tableCount = 22;

  ReadJson() {
    loadJson();
  }

  Future<void> loadJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/menu/menu.json');
      final data = await json.decode(response);
      _items = data["menu"];
      cafeName = data["cafe_name"];
      tableCount = data["table_count"];
      print('read_json: menu okundu');
    } catch (e) {
      print("Error reading JSON: $e");
    }
  }

  int getItemCount() {
    return _items.length;
  }

  List<String> getItemNames() {
    List<String> itemNames = [];
    for (var item in _items) {
      String itemName = item["name"];
      itemNames.add(itemName);
    }
    return itemNames;
  }

  List<dynamic> getItems() {
    return _items;
  }

  void updateSettings(String cafeName, int tableCount) {
    this.cafeName = cafeName;
    this.tableCount = tableCount;
  }

}
