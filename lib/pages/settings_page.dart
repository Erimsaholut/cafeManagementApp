import 'package:adisso/pages/settings/settings_page_widgets/show_change_name_and_table_count_dialog.dart';
import 'package:adisso/pages/settings/settings_sub_pages/create_new_menu_item_page.dart';
import 'package:adisso/pages/settings/settings_sub_pages/edit_items_page.dart';
import '../datas/analyses_data/reset_data_analyses.dart';
import '../datas/menu_data/read_data_menu.dart';
import '../datas/menu_data/reset_datas_menu.dart';
import '../datas/table_orders_data/reset_table_datas.dart';
import '../utils/custom_menu_button.dart';
import '../constants/custom_colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  ReadMenuData readNewData = ReadMenuData();

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
                  customMenuButton("Kafe ismi düzenle", onPressedFunction: () {
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
                  customMenuButton(
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
                  customMenuButton(
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
                  customMenuButton(
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
                  customMenuButton(
                    "Bütün verileri resetle",
                    onPressedFunction: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
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
                                  Navigator.of(dialogContext).pop();
                                },
                                child: const Text('İptal'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (confirmationText == 'Onaylıyorum') {
                                    ResetAllJsonData resetAllJsonData =
                                        ResetAllJsonData();
                                    ResetAllAnalysesJsonData
                                        resetAllAnalysesJsonData =
                                        ResetAllAnalysesJsonData();
                                    ResetAllTableJsonData
                                        resetAllTableJsonData =
                                        ResetAllTableJsonData();

                                    resetAllJsonData.resetMenuToBlank();
                                    await resetAllAnalysesJsonData
                                        .resetAllTableJsonFiles(0);
                                    await resetAllAnalysesJsonData
                                        .resetAllTableJsonFiles(1);
                                    await resetAllAnalysesJsonData
                                        .resetAllTableJsonFiles(2);
                                    resetAllTableJsonData
                                        .resetAllTableJsonFiles();

                                    Navigator.of(dialogContext).pop();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Bütün veriler başarı ile resetlendi'),
                                      ),
                                    );
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
