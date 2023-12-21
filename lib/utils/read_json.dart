import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ReadJson {
  List<dynamic> _items = [];
  String productType;

  ReadJson(this.productType) {
    loadJson();
  }
  Future<void> loadJson() async {
    try {
      final String response =
          await rootBundle.loadString('lib/datas/menu.json');
      final data = await json.decode(response);
      _items = data["menu"][productType];
      print('read_json: okundu $productType');
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


}
