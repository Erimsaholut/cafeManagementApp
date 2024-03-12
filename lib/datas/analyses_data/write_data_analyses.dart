import 'dart:convert';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';

class WriteAnalysesData {
  AnalysesReader analysesDataHandler = AnalysesReader();
  ReadData readData = ReadData();

  Future<void> addItemToAnalysesJson(String prodName,
      int prodQuantity) async {
    try {
      Map<String, dynamic>? rawData = await analysesDataHandler.getRawData();
      double _prodPrice = await readData.getItemPrice(prodName);


      DateTime date = DateTime.now();
      String dateNow = "${date.day}.${date.month}.${date.year}";

      if (rawData != null) {
        // Eğer rawData boş değilse işlemleri gerçekleştir
        if (!rawData.containsKey("sales")) {
          // Eğer "sales" anahtarı yoksa yeni bir harita oluştur
          rawData["sales"] = {};
        }

        if (!rawData["sales"].containsKey(dateNow)) {
          // Eğer verilen tarih için bir giriş yoksa, yeni bir giriş oluştur
          rawData["sales"][dateNow] = {"products": {}};
        }

        if (!rawData["sales"][dateNow]["products"].containsKey(prodName)) {
          // Eğer ürünün listeye eklenmediyse, yeni bir ürün ekle
          rawData["sales"][dateNow]["products"][prodName] = {
            "quantity": prodQuantity,
            "revenue": _prodPrice * prodQuantity
          };
        } else {
          // Eğer ürün listedeyse, miktarını ve gelirini güncelle
          rawData["sales"][dateNow]["products"][prodName]["quantity"] += prodQuantity;
          rawData["sales"][dateNow]["products"][prodName]["revenue"] += _prodPrice * prodQuantity;
        }

        await analysesDataHandler.writeJsonData(jsonEncode(rawData));
      }
    } catch (e) {
      print('Ürün analizi eklenirken hata oluştu: $e');
    }
  }
}
