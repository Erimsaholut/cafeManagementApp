import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';
import '../utils/custom_menu_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar", style: CustomStyles.menuTextStyle),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  CustomMenuButton("Kafe Bilgilerini düzenle"),
                  // isim ve masa sayısı
                  CustomMenuButton("Yeni İçecek Ekle"),
                  CustomMenuButton("Yeni Yiyecek Ekle"),
                  CustomMenuButton("Ürünleri Düzenle"),
                  CustomMenuButton("Eski Verilere Ulaş"),
                  CustomMenuButton("Bütün verileri resetle"),
                  // 1 kere sor 1 kere metni yazdır.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


