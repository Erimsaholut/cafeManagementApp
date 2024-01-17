import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/reset_all_json_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings_page_functions/show_change_name_and_table_count_dialog.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings_sub_pages/create_new_drink_page.dart';
import 'package:flutter/material.dart';
import '../utils/custom_menu_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController _controller = TextEditingController();
  ReadData readNewData = ReadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
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
                    "Kafe ismi düzenle",
                    onPressedFunction: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangeCafeNameDialog(
                            mainTitle: 'Kafe ismi',
                            textFieldTitle: 'Kafe ismini giriniz ? ',
                          );
                        },
                      );
                    },
                  ),
                  CustomMenuButton(
                    "Masa sayısını düzenle",
                    onPressedFunction: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangeTableCountDialog(
                            mainTitle: 'Masa sayısını değiştir',
                            textFieldTitle: 'Masa sayısını giriniz ?',
                          );
                        },
                      );
                    },
                  ),
                  CustomMenuButton("Menüye Yeni Ürün Ekle", onPressedFunction: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const AddNewItemToMenu(),
                        transitionsBuilder: (_, anim, __, child) {
                          return ScaleTransition(
                            scale: anim,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }),
                  CustomMenuButton(
                    "Ürünleri Düzenle",
                    onPressedFunction: () async {
                      Object menu =
                          (await readNewData.readJsonData()) as Object;
                      print(menu);
                      int tableNum = await readNewData.getTableCount();
                      print(tableNum);
                    },
                  ),
                  CustomMenuButton("Eski Verilere Ulaş"),
                  CustomMenuButton(
                    "Bütün verileri resetle",
                    onPressedFunction: () {
                      ResetAllJsonData resetAllJsonData = ResetAllJsonData();
                      resetAllJsonData.resetJsonFile();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bütün veriler başarı ile resetlendi'),
                        ),
                      );
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
