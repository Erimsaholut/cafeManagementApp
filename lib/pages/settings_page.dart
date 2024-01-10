import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/reset_all_json_data.dart';
import 'package:flutter/material.dart';
import '../settings_page_functions/show_change_name_and_table_count_dialog.dart';
import '../utils/custom_menu_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _controller = TextEditingController();
  ReadData readNewData = ReadData();

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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangeNameDialog(
                            mainTitle: "Kafe Bilgilerini Değiştir",
                            textFieldTitle: "Kafe ismini değiştir:",
                            secondTextFieldTitle: "Masa Sayısını Değiştir",
                          );
                        },
                      );
                    },
                  ),
                  CustomMenuButton(
                    "Yeni İçecek Ekle",
                    onPressedFunction: () async {
                      Object menu =
                          (await readNewData.readJsonData()) as Object;
                      print(menu);
                    },
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
}
