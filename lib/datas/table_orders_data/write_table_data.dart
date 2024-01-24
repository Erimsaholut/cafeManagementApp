import 'dart:convert';

import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';

class WriteTableData {
  TableDataHandler tableDataHandler = TableDataHandler();
  ResetTableDatas resetTableDatas = ResetTableDatas();

  Future<void> addItemToTable(
      int tableNum, String itemName, int quantity, double price) async {
    Map<String, dynamic>? rawData = await tableDataHandler.getRawData();
    bool isItemExits = false;

    try {




      if (rawData != null) {
        for (var i in rawData["tables"]) {
          if (i["tableNum"] == tableNum) {
            /*doğru mekanı bul*/
            print("Doğru tableNum aranıyor ve ordersına item ekleniyor");
            print(i);

            /*buldun ama o itemden var mı */
            for (var j in i["orders"]) {
              if (j["name"] == itemName) {
                isItemExits = true;
              }
            }

            print(1);
            /*o itemden yoksa yenisini ekle*/
            if (!isItemExits) {
              print("bu itemden yok");
              Map<String, dynamic> newItem = {
                "name": itemName,
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
          print("bu itemden var");
          for (var i in rawData["tables"]) {
            if (i["tableNum"] == tableNum) {

/*bu kısımda doğru tableSetteyiz*/

              for (var j in i["orders"]) {

                if (j["name"] == itemName) {
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


        await tableDataHandler.writeJsonData(jsonEncode(rawData));
        print("Ekledik galiba");


      }









    } catch (e) {
      print('Yeni ürün eklenirken hata oluştu: $e');
    }
  }

  Future<void> resetData() async {
    try {
      Map<String, dynamic> initialMenu = resetTableDatas.jsonRawDataFirst;
      await tableDataHandler.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile resetlendi");
    } catch (e) {
      print("Resetlenemedi $e");
    }
  }
}
