import 'package:cafe_management_system_for_camalti_kahvesi/utils/styles.dart';
import 'package:flutter/material.dart';

import '../utils/custom_menu_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar", style: CustomStyles.menuTextStyle),backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              CustomMenuButton("Yeni İçecek Ekle"),
              CustomMenuButton("Yeni Yiyecek Ekle"),
              CustomMenuButton("Ürünleri Düzenle"),
              CustomMenuButton("Eski Verilere Ulaş"),
            ],
          ),
        ),
      ),
    );
  }
}
