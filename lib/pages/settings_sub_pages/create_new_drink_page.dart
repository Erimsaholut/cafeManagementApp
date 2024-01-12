import 'package:flutter/material.dart';

import '../settings_page_functions/IntegerExample.dart';

class CreateBeverage extends StatelessWidget {
  const CreateBeverage({Key? key}) : super(key: key);

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
                _buildTextField("İçecek İsmi"),
                IntegerExample(name: "İçecek Fiyatı Belirle"),
                Ingredients(),
                ElevatedButton(
                  onPressed: () {
                    // Burada kullanıcının girdiği verileri kullanabilirsiniz.
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

  Widget _buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class Ingredients extends StatelessWidget {
  Ingredients({super.key});

  List<Widget> widgets = [
    Ingredient(name: "Turşu"),
    Ingredient(name: "Ketçap"),
    Ingredient(name: "Mayonez")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Malzemeler", style: Theme.of(context).textTheme.titleLarge),
        Row(
          children: [
            ...widgets,
          ],
        ),
      ],
    );
  }
}

class Ingredient extends StatelessWidget {
  final String name;

  Ingredient({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        color: Colors.white,
        child: Row(
          children: [
            Text(name),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                  Icons.clear), // Fix: Added 'Icon' before 'Icons.clear'
            ),
          ],
        ),
      ),
      SizedBox(
        width: 15,
      ),
    ]);
  }
}
