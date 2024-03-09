import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings/settings_page_widgets/show_change_name_and_table_count_dialog.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings/settings_sub_pages/create_new_drink_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_alert_button.dart';
import 'package:flutter/material.dart';
import '../datas/menu_data/reset_datas_menu.dart';

import '../utils/custom_menu_button.dart';
import 'settings/settings_sub_pages/edit_items.dart';

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
                  CustomMenuButton("Menüye Yeni Ürün Ekle",
                      onPressedFunction: () {
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
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => EditItems(),
                          transitionsBuilder: (_, anim, __, child) {
                            return ScaleTransition(
                              scale: anim,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  ),
                  CustomMenuButton("Eski Verilere Ulaş"),
                  CustomMenuButton(
                    "Bütün verileri resetle",
                    onPressedFunction: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertButton(
                              answer1: 'Kapat',
                              text1: 'Bütün veriler resetlenecektir.',
                              text2: 'Onaylıyor musunuz ?',
                              customFunction: () {
                                ResetAllJsonData resetAllJsonData =
                                    ResetAllJsonData();
                                resetAllJsonData.resetJsonFile();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Bütün veriler başarı ile resetlendi'),
                                  ),
                                );
                              },
                            );
                          });
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
