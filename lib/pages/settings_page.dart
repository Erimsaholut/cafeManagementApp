import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings/settings_page_widgets/show_change_name_and_table_count_dialog.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings/settings_sub_pages/create_new_menu_item_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings/settings_sub_pages/edit_items_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import '../constants/custom_colors.dart';
import '../datas/menu_data/reset_datas_menu.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  ReadData readNewData = ReadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Container(
        color: CustomColors.backGroundColor,
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  CustomMenuButton("Kafe ismi düzenle", onPressedFunction: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ChangeCafeNameDialog(
                          mainTitle: 'Kafe ismi',
                          textFieldTitle: 'Kafe ismini giriniz ? ',
                        );
                      },
                    );
                  }, context: context),
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
                    context: context,
                  ),
                  CustomMenuButton(
                    "Menüye Yeni Ürün Ekle",
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
                    },
                    context: context,
                  ),
                  CustomMenuButton(
                    "Ürünleri Düzenle",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => const EditItemsPage(),
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
                    context: context,
                  ),
                  CustomMenuButton("Eski Verilere Ulaş", context: context),
                  CustomMenuButton(
                    "Bütün verileri resetle",
                    onPressedFunction: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String confirmationText = '';

                          return AlertDialog(
                            title: const Text('Verileri Sıfırla'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  'Bütün verileri sıfırlamak için "Onaylıyorum" yazmalısınız.',
                                ),
                                TextField(
                                  onChanged: (text) {
                                    confirmationText = text;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Metin Alanı',
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
                                onPressed: () {
                                  if (confirmationText == 'Onaylıyorum') {
                                    ResetAllJsonData resetAllJsonData =
                                    ResetAllJsonData();
                                    resetAllJsonData.resetJsonFile();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Bütün veriler başarı ile resetlendi'),),);
                                    //todo analizleri de resetlemeli
                                  } else {
                                    // Onay metni doğru değilse kullanıcıyı uyar
                                    print('Lütfen doğru onay metnini girin.');
                                  }
                                },
                                child: const Text('Onayla'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    context: context,
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//todo burada bir sıkıntı zerk etti