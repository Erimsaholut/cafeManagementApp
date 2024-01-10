import 'package:cafe_management_system_for_camalti_kahvesi/datas/reset_all_json_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/write_data.dart';
import 'package:flutter/material.dart';
import '../utils/custom_menu_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _controller = TextEditingController();

  WriteData writeData = WriteData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  CustomMenuButton(
                    "Kafe Bilgilerini düzenle",
                    onPressedFunction: () {
                      showChangeNameDialog(
                        "Kafe Bilgilerini Değiştir",
                        "Kafe ismini değiştir:",
                        "Masa Sayısını Değiştir",
                      ); // showDialog metodu burada çağrılır
                    },
                  ),
                  CustomMenuButton(
                    "Yeni İçecek Ekle",
                    onPressedFunction: () {},
                  ),
                  CustomMenuButton("Yeni Yiyecek Ekle"),
                  CustomMenuButton("Ürünleri Düzenle"),
                  CustomMenuButton("Eski Verilere Ulaş"),
                  CustomMenuButton(
                    "Bütün verileri resetle",
                    onPressedFunction: () {
                      ResetAllJsonData resetAllJsonData = ResetAllJsonData();
                      resetAllJsonData.resetJsonFile();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showChangeNameDialog(
    //todo dışarı salla bunu
    String mainTitle,
    String textFieldTitle,
    String secondTextFieldTitle,
  ) async {
    TextEditingController _secondController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mainTitle),
          content: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: textFieldTitle,
                ),
              ),
              TextField(
                controller: _secondController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: secondTextFieldTitle,
                ),
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
              onPressed: () async {
                bool updateName = _controller.text.isNotEmpty;
                bool updateMasaSayisi = _secondController.text.isNotEmpty &&
                    RegExp(r'^[0-9]+$').hasMatch(_secondController.text);

                if (updateName || updateMasaSayisi) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Emin misiniz?'),
                        content: const Text(
                            'Değişiklikleri kaydetmek istediğinizden emin misiniz?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (updateName) {
                                setState(() {
                                  writeData.setCafeName(_controller.text);
                                  print(
                                      "data.cafeName = _controller.text; calisti");
                                });
                                _controller.clear();
                              }

                              if (updateMasaSayisi) {
                                int tableCount =
                                    int.parse(_secondController.text);
                                writeData.setTableCount(tableCount);
                                print(" data.tableCount = masaSayisi; calisti");
                                _secondController.clear();
                                Navigator.of(context).pop();
                              }

                              Navigator.of(context).pop();
                            },
                            child: const Text('Evet'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Uyarı'),
                        content: const Text(
                            'En az bir değeri güncellemek için bir bilgi girin.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }
}
