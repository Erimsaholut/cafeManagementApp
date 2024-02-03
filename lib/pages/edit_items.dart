import 'package:flutter/material.dart';
import '../datas/menu_data/read_data.dart';
import 'settings/settings_page_widgets/price_picker.dart';

class EditItems extends StatelessWidget {
  EditItems({super.key});

  ReadData readData = ReadData();
  TextEditingController nameController = TextEditingController();
  int moneyValue = 0;
  int pennyValue = 0;

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
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data?['menu'] == null) {
              return const Text('No data available.');
            } else {
              List<dynamic> menuItems = snapshot.data!['menu'];

              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: menuItems.map((item) {
                  return TextButton(
                    onPressed: () {
                      double doubleMoneyValue = item["price"];
                      int InitialMoneyValue = doubleMoneyValue.truncate();
                      int InitialPennyValue =
                          ((doubleMoneyValue - InitialMoneyValue) * 100)
                              .round();

                      nameController.text = item["name"];

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Edit Item"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("İsim"),
                                  TextFormField(
                                    controller: nameController,
                                  ),
                                  const SizedBox(height: 16),
                                  PricePicker(
                                    name: "Fiyat",
                                    initialMoney: InitialMoneyValue,
                                    initialPenny: InitialPennyValue,
                                    onValueChanged: (int money, int penny) {
                                      moneyValue = money;
                                      pennyValue = penny;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Text("Secenekler:"),
                                  item['ingredients'].isEmpty
                                      ? const Column(
                                          children: [
                                            SizedBox(height: 16,),
                                            Text('Bu ürün için seçenek yoktur.')
                                          ],
                                        )
                                      : Column(
                                          children: List<Widget>.generate(
                                            item['ingredients'].length,
                                            (index) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        item['ingredients']
                                                            [index])),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.amberAccent,
                                                    ),
                                                    onPressed: () {
                                                      // İlk IconButton'a tıklandığında yapılacak işlemler
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      // İkinci IconButton'a tıklandığında yapılacak işlemler
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  const SizedBox(height: 16,),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("Seçenek Ekle"),
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
                                  // Örneğin: nameController.text, moneyValue, pennyValue
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
                          return null;
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
