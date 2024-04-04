import 'dart:convert';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';

class WriteAnalysesData {
  AnalysesReader analysesDataHandler = AnalysesReader();
  ReadData readData = ReadData();

  Future<void> addItemToAnalysesJson(String prodName,
      int prodQuantity) async {
    try {
      Map<String, dynamic>? rawData = await analysesDataHandler.getRawData(0);
      double _prodPrice = await readData.getItemPrice(prodName);


      DateTime date = DateTime.now();
      String dateNow = "${date.day}.${date.month}.${date.year}";

      if (rawData != null) {
        if (!rawData.containsKey("sales")) {
          rawData["sales"] = {};
        }

        if (!rawData["sales"].containsKey(dateNow)) {
          rawData["sales"][dateNow] = {"products": {}};
        }

        if (!rawData["sales"][dateNow]["products"].containsKey(prodName)) {
          rawData["sales"][dateNow]["products"][prodName] = {
            "quantity": prodQuantity,
            "revenue": _prodPrice * prodQuantity
          };
        } else {
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
