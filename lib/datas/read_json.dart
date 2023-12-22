import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ReadJson {
  List<dynamic> _items = [];

  ReadJson() {
    loadJson();
  }
  Future<void> loadJson() async {
    try {
      final String response =
          await rootBundle.loadString('lib/datas/menu.json');
      final data = await json.decode(response);
      _items = data["menu"];
      print('read_json: menu okundu');
    } catch (e) {
      print("Error reading JSON: $e");
    }
  }

  int getItemCount(){
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

  List<dynamic> getItems(){
    return _items;
  }


}
