import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_json.dart';

class PrepareData {
  late ReadJson _readJson;
  late List<dynamic> _rawData;
  late List<Map<String, dynamic>> _foodRaw = [];
  late List<Map<String, dynamic>> _drinkRaw = [];

  static List<String> _drinksWithNoIngredients = [];
  static List<String> _drinksWithIngredients = [];

  static List<String> _foodsWithIngredients = [];
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
          _foodsWithIngredients.add(itemName);
        } else {
          _foodsWithNoIngredients.add(itemName);
        }
      } else if (itemType == "drink") {
        _drinkRaw.add(item);
        if (ingredients.isNotEmpty) {
          _drinksWithIngredients.add(itemName);
        } else {
          _drinksWithNoIngredients.add(itemName);
        }
      }
    }
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


  void clearLists() {
    _drinksWithIngredients.clear();
    _drinksWithNoIngredients.clear();
    _foodsWithIngredients.clear();
    _foodsWithNoIngredients.clear();
  }


  List<String> getDrinksWithIngredients() {
    return _drinksWithIngredients;
  }

  List<String> getDrinksWithNoIngredients() {
    return _drinksWithNoIngredients;
  }

  List<String> getFoodsWithIngredients() {
    return _foodsWithIngredients;
  }

  List<String> getFoodsWithNoIngredients() {
    return _foodsWithNoIngredients;
  }
  List<dynamic> getRawData() {
    return _rawData;
  }
}
