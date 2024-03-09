import 'dart:convert';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';

class WriteAnalysesData {
  AnalysesReader analysesDataHandler = AnalysesReader();

  Future<void> addItemToTable(DateTime dateTime, String product, int quantity, double price) async {
    Map<String, dynamic>? rawData = await analysesDataHandler.getRawData();

    try {
      if (rawData != null) {
        for (var i in rawData["sales"]) {
          if (i["tableNum"] == tableNum) {
            /*doğru mekanı bul*/

            /*o itemden yoksa yenisini ekle*/
            if (!isItemExits) {
              Map<String, dynamic> newItem = {
                "name": product,
                "quantity": quantity,
                "price": price,
              };

              i["orders"].add(newItem); // önce bi kontrol
              double oldPrice = i["totalPrice"];
              oldPrice += price;
              i["totalPrice"] = oldPrice;
            }
          }
        }

        if (isItemExits) {
          for (var i in rawData["tables"]) {
            if (i["tableNum"] == tableNum) {
              /*bu kısımda doğru tableSetteyiz*/

              for (var j in i["orders"]) {
                if (j["name"] == product) {
                  int oldQuantity = j["quantity"];
                  oldQuantity += quantity;
                  j["quantity"] = oldQuantity;

                  double oldPrice = j["price"];
                  oldPrice += price;
                  j["price"] = oldPrice;

                  double oldTotalPrice = i["totalPrice"];
                  oldTotalPrice += price;
                  i["totalPrice"] = oldTotalPrice;
                }
              }
            }
          }
        }

        await analysesDataHandler.writeJsonData(jsonEncode(rawData));
      }
    } catch (e) {
      print('Yeni ürün eklenirken hata oluştu: $e');
    }
  }

  Future<void> resetOneTable(int tableNum) async {
    try {
      Map<String, dynamic>? rawData = await analysesDataHandler.getRawData();

      if (rawData != null) {
        for (var table in rawData["tables"]) {
          if (table["tableNum"] == tableNum) {
            /*doğru mekanı bul*/
            print("Doğru tableNum aranıyor ve orders resetleniyor");
            table["totalPrice"] = 0.0;
            table["orders"] = [];
            print(table);
          }
        }
      }

      await analysesDataHandler.writeJsonData(jsonEncode(rawData));
      print("Resetledik galiba");
    } catch (e) {
      print("Resetlenemedi $e");
    }
  }

}
