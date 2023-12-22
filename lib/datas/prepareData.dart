import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_json.dart';

class PrepareData {
  late ReadJson readJson;
  late List<dynamic> rawData;
  late List<Map<String, dynamic>> foodRaw = [];
  late List<Map<String, dynamic>> drinkRaw = [];
  late List<String> drinksWithNoIngredients = [];
  late List<String> drinksWithIngredients = [];
  late List<String> foodsWithIngredients = [];
  late List<String> foodsWithNoIngredients = [];

  PrepareData() {
    readJson = ReadJson();
    initializeData();
  }

  Future<void> initializeData() async {
    await readJson.loadJson(); // JSON dosyasını yükleyin
    rawData = readJson.getItems();
    separateData();
  }

  void separateData() {
    for (int i = 0; i < readJson.getItemCount(); i++) {
      Map<String, dynamic> item = rawData[i];
      String itemName = item["name"];
      String itemType = item["type"];
      List<String> ingredients = item["ingredients"] != null
          ? List<String>.from(item["ingredients"])
          : [];

      if (itemType == "food") {
        foodRaw.add(item);
        if (ingredients.isNotEmpty) {
          foodsWithIngredients.add(itemName);
        } else {
          foodsWithNoIngredients.add(itemName);
        }
      } else if (itemType == "drink") {
        drinkRaw.add(item);
        if (ingredients.isNotEmpty) {
          drinksWithIngredients.add(itemName);
        } else {
          drinksWithNoIngredients.add(itemName);
        }
      }
    }

    print("Foods with Ingredients: $foodsWithIngredients");
    print("Foods with No Ingredients: $foodsWithNoIngredients");

    print("Drinks with Ingredients: $drinksWithIngredients");
    print("Drinks with No Ingredients: $drinksWithNoIngredients");
  }
}
