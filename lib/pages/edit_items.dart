import 'package:flutter/material.dart';
import '../datas/menu_data/read_data.dart';
import '../utils/custom_alert_button.dart';

class EditItems extends StatelessWidget {
  EditItems({super.key});

  ReadData readData = ReadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Items"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        child: FutureBuilder<Map<String, dynamic>?>(
          future: readData.getRawData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // or any loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data?['menu'] == null) {
              return Text('No data available.');
            } else {
              List<dynamic> menuItems = snapshot.data!['menu'];

              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: menuItems.map((item) {
                  return TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Edit Item"),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Name'),
                                    // Burada kullanıcıdan isim alıyoruz.
                                  ),
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Price'),
                                    keyboardType: TextInputType.number,
                                    // Burada kullanıcıdan fiyat alıyoruz.
                                  ),
                                  SizedBox(height: 16.0),
                                  Text("Ingredients:"),
                                  // Burada item["ingredients"] listesindeki eleman sayısı kadar checkbox oluşturuyoruz.
                                  ...List.generate(
                                    item['ingredients'].length,
                                    (index) => CheckboxListTile(
                                      title: Text(item['ingredients'][index]),
                                      value: false,
                                      // Checkbox başlangıç değeri, kullanıcı seçim yapacak.
                                      onChanged: (bool? value) {
                                        // Checkbox değeri değiştiğinde burada işlemler yapılabilir.
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Burada kullanıcının girdiği değerleri kullanabilirsiniz.
                                  // Örneğin: nameController.text, priceController.text, selectedIngredients
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          return null; // Use the default value.
                        },
                      ),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(item['name']),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
