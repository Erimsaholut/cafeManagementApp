import 'package:flutter/material.dart';
import '../../utils/custom_divider.dart';
import '../settings_page_functions/ingredients.dart';
import '../settings_page_functions/price_picker.dart';
import '../settings_page_functions/custom_text_field.dart';

class CreateBeverage extends StatefulWidget {
  const CreateBeverage({Key? key}) : super(key: key);

  @override
  _CreateBeverageState createState() => _CreateBeverageState();
}

class _CreateBeverageState extends State<CreateBeverage> {
  final TextEditingController beverageNameController = TextEditingController();
  Ingredients ingredients = Ingredients();
  int moneyValue = 15;
  int pennyValue = 0;
  late String beverageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Beverage"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                buildCustomTextField("İçecek İsmi", beverageNameController),
                customDivider(),
                PricePicker(
                  name: "İçecek Fiyatı Belirle",
                  onValueChanged: (int money, int penny) {
                    setState(() {
                      moneyValue = money;
                      pennyValue = penny;
                    });
                  },
                ),
                customDivider(),
                Ingredients(),
                customDivider(),
                ElevatedButton(
                  onPressed: () {
                    beverageName = beverageNameController.text;
                    print("$beverageName,$moneyValue,$pennyValue");

                    //List<String> ingredientNames = ingredients.getIngredientNames();
                    print("Ingredient Names: $ingredientNames");
                  },
                  child: const Text("Kaydet"),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
