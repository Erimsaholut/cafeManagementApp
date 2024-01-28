import 'dart:convert';

import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';

class WriteTableData {
  TableDataHandler tableDataHandler = TableDataHandler();
  ResetTableDatas resetTableDatas = ResetTableDatas();

  Future<void> addItemToTable(int tableNum, String itemName, int quantity,
      double price) async {
    Map<String, dynamic>? rawData = await tableDataHandler.getRawData();
    bool isItemExits = false;

    try {
      if (rawData != null) {
        for (var i in rawData["tables"]) {
          if (i["tableNum"] == tableNum) {
            /*doğru mekanı bul*/

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
      }
    } catch (e) {
      print('Yeni ürün eklenirken hata oluştu: $e');
    }
  }

  Future<void> resetAllData() async {
    try {
      Map<String, dynamic> initialMenu = resetTableDatas.jsonRawDataFirst;
      await tableDataHandler.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile resetlendi");
    } catch (e) {
      print("Resetlenemedi $e");
    }
  }

  Future<void> resetOneTable(int tableNum) async {
    try {
      Map<String, dynamic>? rawData = await tableDataHandler.getRawData();

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

      await tableDataHandler.writeJsonData(jsonEncode(rawData));
      print("Resetledik galiba");
    } catch (e) {
      print("Resetlenemedi $e");
    }
  }

  Future<void> decreaseOneItem(int tableNum, String itemName,
      int decreaseCount,) async {
    try {
      Map<String, dynamic>? rawData = await tableDataHandler.getRawData();

      if (rawData != null) {
        // Tablo numarası kontrolü
        bool tableFound = false;
        for (var table in rawData["tables"]) {
          if (table["tableNum"] == tableNum) {
            tableFound = true;
            print("#####$table");
            List<dynamic> itemsToRemove = [];

            for (var order in table["orders"]) {
              if (order["name"] == itemName) {
                print("#####$order");

                // Sıfırdan küçük kontrolü
                if (decreaseCount <= 0) {
                  print("decreaseCount should be greater than 0");
                  // Hata durumu ile başa çıkma
                  return;
                }

                double orderPrice = order["price"] / order["quantity"];

                order["quantity"] = order["quantity"] - decreaseCount;

                order["price"] =
                    order["price"] - (orderPrice * decreaseCount);

                table["totalPrice"] =
                    table["totalPrice"] - (orderPrice * decreaseCount);

                // Sipariş miktarı sıfırdan küçük veya eşitse, siparişi kaldır
                if (order["quantity"] <= 0) {
                  itemsToRemove.add(order);
                }
              }
            }

            // Kaldırılacak öğeleri kaldır
            for (var itemToRemove in itemsToRemove) {
              table["orders"].remove(itemToRemove);
            }
          }
        }

        // Tablo bulunamazsa
        if (!tableFound) {
          print("Table not found");
          // Hata durumu ile başa çıkma
          return;
        }

        // JSON verisini güncelle
        await tableDataHandler.writeJsonData(jsonEncode(rawData));
      } else {
        print("rawData is null");
        // Hata durumu ile başa çıkma
      }
    } catch (e) {
      print("An error occurred: $e");
      // Hata durumu ile başa çıkma
    }
  }


}
