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
                const Divider(
                  color: Colors.white,
                  thickness: 3,
                  indent: 200,
                  endIndent: 200,
                ),
                IntegerExample(name: "İçecek Fiyatı Belirle"),
                const Divider(
                  color: Colors.white,
                  thickness: 3,
                  indent: 200,
                  endIndent: 200,
                ),
                Ingredients(),
                const Divider(
                  color: Colors.white,
                  thickness: 3,
                  indent: 200,
                  endIndent: 200,
                ),
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
}

class Ingredients extends StatefulWidget {
  Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  final List<Widget> indWidgets = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Malzemeler", style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: indWidgets.isEmpty
              ? _buildEmptyIngredientsMessage()
              : _buildIngredientsList(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Seçenek İsmi"),
                  content: Column(
                    children: [
                      TextField(
                        controller: _controller,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('İptal'),
                    ),
                    TextButton(
                      onPressed: () {
                        bool updateName = _controller.text.isNotEmpty;
                        if (updateName) {
                          setState(() {
                            indWidgets.add(
                              Ingredient(
                                name: _controller.text,
                                onDelete: () =>
                                    _removeIngredient(indWidgets.length),
                              ),
                            );
                            _controller.clear();
                            Navigator.of(context).pop();
                          });
                        } else {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Seçenek eklemek için bir değer girin.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Kaydet'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("Seçenek ekle"),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildIngredientsList() {
    return Wrap(
      spacing: 323.0,
      runSpacing: 8.0,
      children: [
        for (int i = 0; i < indWidgets.length; i++)
          Ingredient(
            name: (indWidgets[i] as Ingredient).name,
            onDelete: () => _removeIngredient(i),
          ),
      ],
    );
  }

  Widget _buildEmptyIngredientsMessage() {
    return const Column(
      children: [
        Text(
          "Malzeme eklemek için aşağıdaki butona basabilirsiniz.",
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _removeIngredient(int index) {
    setState(() {
      indWidgets.removeAt(index);
    });
  }
}

class Ingredient extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const Ingredient({Key? key, required this.name, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}

Widget _buildTextField(String labelText) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 18.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}
