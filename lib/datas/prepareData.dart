import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_json.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';

class PrepareData {
  late ReadJson _readJson;
  late List<dynamic> _rawData;
  late List<Map<String, dynamic>> _foodRaw = [];
  late List<Map<String, dynamic>> _drinkRaw = [];

  static List<String> _drinksWithNoIngredients = [];
  static List<Map<String, dynamic>> _drinksWithIngredients = [];

  static List<Map<String, dynamic>> _foodsWithIngredients = [];
  static List<String> _foodsWithNoIngredients = [];

  PrepareData() {
    _readJson = ReadJson();
    print('PrepareData is working');
    initializeData();
  }

  Future<void> initializeData() async {
    print("initialization is working");
    await _readJson.loadJson();
    _rawData = _readJson.getItems();
    _separateData();
  }

  void _separateData() {
    clearLists();
    for (int i = 0; i < _rawData.length; i++) {
      Map<String, dynamic> item = _rawData[i];
      String itemName = item["name"];
      String itemType = item["type"];
      List<String> ingredients = item["ingredients"] != null
          ? List<String>.from(item["ingredients"])
          : [];

      if (itemType == "food") {
        _foodRaw.add(item);
        if (ingredients.isNotEmpty) {
          _foodsWithIngredients
              .add({"name": itemName, "ingredients": ingredients});
        } else {
          _foodsWithNoIngredients.add(itemName);
        }
      } else if (itemType == "drink") {
        _drinkRaw.add(item);
        if (ingredients.isNotEmpty) {
          _drinksWithIngredients
              .add({"name": itemName, "ingredients": ingredients});
        } else {
          _drinksWithNoIngredients.add(itemName);
        }
      }
    }
  }

  void clearLists() {
    _drinksWithIngredients.clear();
    _drinksWithNoIngredients.clear();
    _foodsWithIngredients.clear();
    _foodsWithNoIngredients.clear();
  }

  int? getItemPrice(String itemName) {
    for (int i = 0; i < _rawData.length; i++) {
      Map<String, dynamic> item = _rawData[i];
      if (item["name"] == itemName) {
        return item["price"];
      }
    }
    return null;
  }

  List<Map<String, dynamic>> getDrinksWithIngredients() {
    return _drinksWithIngredients;
  }

  List<String> getDrinksWithNoIngredients() {
    return _drinksWithNoIngredients;
  }

  List<Map<String, dynamic>> getFoodsWithIngredients() {
    return _foodsWithIngredients;
  }

  List<String> getFoodsWithNoIngredients() {
    return _foodsWithNoIngredients;
  }

  List<dynamic> getRawData() {
    return _rawData;
  }

  set cafeName(String name) {
    _readJson.cafeName = name;
    print("CAFE NAME ");
    _updateSettingsInJSON();
  }

  set tableCount(int count) {
    _readJson.tableCount = count;
    _updateSettingsInJSON();
  }

  Future<void> _updateSettingsInJSON() async {
    final String response = await rootBundle.loadString('lib/datas/menu.json');
    final data = await json.decode(response);

    // Yeni ayarları ekle
    data["cafe_name"] = _readJson.cafeName;
    data["table_count"] = _readJson.tableCount;
    print(data);

// Güncellenmiş içeriği dosyaya yaz
    final String jsonString = json.encode(data);

    // Specify the path to the JSON file
    const String filePath = '/Users/erimsaholut/StudioProjects/cafe_management_system_for_camalti_kahvesi/lib/datas/menu.json';

    // Create a File object
    final File file = File(filePath);

    // Write the updated JSON content to the file
    file.writeAsStringSync(jsonString);
  }
}
