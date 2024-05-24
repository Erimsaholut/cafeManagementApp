import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class ReadMenuData {
  ReadMenuData() {
    readJsonData();
  }

  final List<String> _drinksWithNoIngredients = [];
  final List<Map<String, dynamic>> _drinksWithIngredients = [];
  final List<Map<String, dynamic>> _foodsWithIngredients = [];
  final List<String> _foodsWithNoIngredients = [];

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
      print('Error writing JSON data: $e');
    }
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
      print('Error reading JSON data: $e');
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
      print('Error getting menu item count: $e');
    }
    return 0;
  }

  Future<void> separateMenuItems() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final file = File('$path/menu.json');
      if (await file.exists()) {
        String content = await file.readAsString();
        print("content$content");
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          List<dynamic> menu = jsonData["menu"];

          // Clear the lists before separating items
          _drinksWithNoIngredients.clear();
          _drinksWithIngredients.clear();
          _foodsWithIngredients.clear();
          _foodsWithNoIngredients.clear();

          for (var item in menu) {
            String itemName = item["name"];
            String itemType = item["type"];
            List<String> ingredients = item["ingredients"] != null
                ? List<String>.from(item["ingredients"])
                : [];

            if (!_menuItemExists(itemName)) {
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
      print('Error separating menu items: $e');
    }
  }

  bool _menuItemExists(String itemName) {
    return _drinksWithIngredients.any((item) => item["name"] == itemName) ||
        _drinksWithNoIngredients.contains(itemName) ||
        _foodsWithIngredients.any((item) => item["name"] == itemName) ||
        _foodsWithNoIngredients.contains(itemName);
  }

  Future<Map<String, dynamic>?> getRawData() async {
    return await readJsonData();
  }

  Future<double> getItemPrice(String itemName) async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          List<dynamic> menu = jsonData["menu"];
          for (var item in menu) {
            if (item["name"] == itemName) {
              return item["price"]?.toDouble() ?? 0.0;
            }
          }
        }
      }
    } catch (e) {
      print('Error getting item price: $e');
    }
    return 0.0;
  }

  Future<double> getItemProfit(String itemName) async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonData = jsonDecode(content);
          List<dynamic> menu = jsonData["menu"];
          for (var item in menu) {
            if (item["name"] == itemName) {
              return item["profit"]?.toDouble() ?? 0.0;
            }
          }
        }
      }
    } catch (e) {
      print('Error getting item profit: $e');
    }
    return 0.0;
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

  Future<void> initialize() async {
    await separateMenuItems();
  }
}
