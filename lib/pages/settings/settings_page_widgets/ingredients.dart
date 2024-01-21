import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class Ingredients extends StatefulWidget {
  Ingredients({super.key, required this.indList});

  List<String> indList;

  @override
  State<Ingredients> createState() => _IngredientsState(indList: indList);
}

class _IngredientsState extends State<Ingredients> {
  final List<Widget> indWidgets = [];
  final TextEditingController _controller = TextEditingController();
  List<String> indList;

  _IngredientsState({required this.indList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Seçenekler", style: CustomStyles.blackAndBoldTextStyleXl),
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
                            indList.add(_controller.text);
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
      runSpacing: 16.0,
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
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: const Text(
                "Seçenekler menüsünü içecekler için farklı türleri belirtmek için kullanabilirsiniz"
                "\nÖrneğin: Nescafe -> Sade, ikisi bir arada, üçü bir arada "
                "\n\nYiyecekler için ise malzemeleri belirlemek için kullanabilirsiniz"
                "\nÖrneğin: Karışık Tost -> Ketçap, Mayonez, Soğan, Domates",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
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

  String getName() {
    return name;
  }
}
