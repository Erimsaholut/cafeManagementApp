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

  /**/
  final Map<String, List<Map<String, dynamic>>> _categorizedItems = {};

  Future<void> separateMenuItemsByCategory() async {
    final jsonData = await readJsonData();
    if (jsonData != null) {
      List<dynamic> menu = jsonData["menu"];
      _categorizedItems.clear();
      for (var item in menu) {
        String itemType = item["type"];
        if (!_categorizedItems.containsKey(itemType)) {
          _categorizedItems[itemType] = [];
        }
        _categorizedItems[itemType]?.add(item);
      }
    }
  }

  Map<String, List<Map<String, dynamic>>> getCategorizedItems() {
    return _categorizedItems;
  }
/**/


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/menu.json');
  }

  Future<void> writeJsonData(String jsonData) async {
    try {
      final file = await _localFile;
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
    final jsonData = await readJsonData();
    if (jsonData != null) {
      List<dynamic> menu = jsonData["menu"];
      return menu.length;
    }
    return 0;
  }

  Future<List<String>> getCategories() async {
    final jsonData = await readJsonData();
    if (jsonData != null) {
      List<dynamic> categoriesDynamic = jsonData["categories"];
      List<String> categories = categoriesDynamic.map((category) => category.toString()).toList();
      return categories;
    }
    return [];
  }

  Future<void> separateMenuItems() async {
    final jsonData = await readJsonData();
    if (jsonData != null) {
      List<dynamic> menu = jsonData["menu"];
      _clearLists();
      for (var item in menu) {
        _addItemToList(item);
      }
    }
  }

  void _clearLists() {
    _drinksWithNoIngredients.clear();
    _drinksWithIngredients.clear();
    _foodsWithIngredients.clear();
    _foodsWithNoIngredients.clear();
  }

  void _addItemToList(Map<String, dynamic> item) {
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
    return await _getItemProperty(itemName, "price");
  }

  Future<double> getItemProfit(String itemName) async {
    return await _getItemProperty(itemName, "profit");
  }

  Future<double> _getItemProperty(String itemName, String property) async {
    final jsonData = await readJsonData();
    if (jsonData != null) {
      List<dynamic> menu = jsonData["menu"];
      for (var item in menu) {
        if (item["name"] == itemName) {
          return item[property]?.toDouble() ?? 0.0;
        }
      }
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
