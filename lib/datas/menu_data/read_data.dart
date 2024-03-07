import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReadData {
  ReadData() {
    readJsonData();
  }

  static final List<String> _drinksWithNoIngredients = [];
  static final List<Map<String, dynamic>> _drinksWithIngredients = [];

  static final List<Map<String, dynamic>> _foodsWithIngredients = [];
  static final List<String> _foodsWithNoIngredients = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/menu.json');
  }

  Future<void> writeJsonData(String jsonData) async {
    final file = await _localFile;
    try {
      await file.writeAsString(jsonData);
      print("Settings updated successfully.");
    } catch (e) {
      print('JSON verisi yazılırken hata oluştu: $e');
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
        }
      }
    } catch (e) {
      print('JSON verisi okunurken hata oluştu: $e');
    }
    return null;
  }

  Future<int> getMenuItemCount() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          List<dynamic> menu = jsonData["menu"];
          return menu.length;
        }
      }
    } catch (e) {
      print('Menü öğe sayısı alınırken hata oluştu: $e');
    }
    return 0;
  }

  Future<void> separateMenuItems() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();

        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          List<dynamic> menu = jsonData["menu"];

          for (var item in menu) {
            String itemName = item["name"];
            String itemType = item["type"];
            List<String> ingredients = item["ingredients"] != null
                ? List<String>.from(item["ingredients"])
                : [];

            bool itemExists = _menuItemExists(itemName);

            if (!itemExists) {
              if (itemType == "drink") {
                if (ingredients.isNotEmpty) {
                  _drinksWithIngredients
                      .add({"name": itemName, "ingredients": ingredients});
                } else {
                  _drinksWithNoIngredients.add(itemName);
                }
              } else if (itemType == "food") {
                if (ingredients.isNotEmpty) {
                  _foodsWithIngredients
                      .add({"name": itemName, "ingredients": ingredients});
                } else {
                  _foodsWithNoIngredients.add(itemName);
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print('Menü öğeleri ayrıştırılırken hata oluştu: $e');
    }
  }

  bool _menuItemExists(String itemName) {
    for (var existingItem in _drinksWithIngredients) {
      if (existingItem["name"] == itemName) {
        return true;
      }
    }

    for (var existingItem in _drinksWithNoIngredients) {
      if (existingItem == itemName) {
        return true;
      }
    }

    for (var existingItem in _foodsWithIngredients) {
      if (existingItem["name"] == itemName) {
        return true;
      }
    }

    for (var existingItem in _foodsWithNoIngredients) {
      if (existingItem == itemName) {
        return true;
      }
    }

    return false;
  }

  Future<Map<String, dynamic>?> getRawData() async {
    try {
      return await readJsonData();
    } catch (e) {
      print('Raw data okunurken hata oluştu: $e');
      return null;
    }
  }

  Future<String> getCafeName() async {
    try {
      Map<String, dynamic>? rawData = await getRawData();

      if (rawData != null) {
        return rawData["cafe_name"];
      }
    } catch (e) {
      print('Cafe adı okunurken hata oluştu: $e');
    }
    return "";
  }

  Future<double> getItemPrice(String itemName) async {
    try {
      final file = await _localFile;

      if (await file.exists()) {

        String content = await file.readAsString();

        if (content.isNotEmpty) {

          Map<String, dynamic> jsonData = jsonDecode(content);

          List<dynamic> menu = jsonData["menu"];

          for(var i in menu){
            if(i["name"]==itemName){
              print(i["price"]);
              return i["price"];
            }
          }
          return 0;

        }

      }
    } catch (e) {
      print('ürünün fiyatı alınırken hata oluştu: $e');
    }
    return 0;
  }

  Future<int> getTableCount() async {
    try {
      Map<String, dynamic>? rawData = await getRawData();

      if (rawData != null) {
        return rawData["table_count"];
      }
    } catch (e) {
      print('Masa sayisi hata oluştu: $e');
    }
    return -1;
  }

  List<Map<String, dynamic>> get drinksWithIngredients =>
      _drinksWithIngredients;

  List<String> get drinksWithNoIngredients => _drinksWithNoIngredients;

  List<Map<String, dynamic>> get foodsWithIngredients => _foodsWithIngredients;

  List<String> get foodsWithNoIngredients => _foodsWithNoIngredients;


}
