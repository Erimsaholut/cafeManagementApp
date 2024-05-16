import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/write_data_analyses.dart';
import 'dart:convert';

class WriteTableData {
  WriteAnalysesData writeAnalysesData = WriteAnalysesData();
  ResetTableDatas resetTableDatas = ResetTableDatas();
  TableReader tableDataHandler = TableReader();

  Future<void> addItemToTable(
      int tableNum, String itemName, int quantity, double price) async {
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

            /*o itemden yoksa yenisini ekle*/
            if (!isItemExits) {
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
      ResetTableDatas resetTables = ResetTableDatas();
      resetTables.createTables(22);
      await tableDataHandler
          .writeJsonData(jsonEncode(resetTables.jsonRawDataFirst));
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

  Future<void> decreaseItemList(
      int tableNum, Map<String, int> removeList) async {
    try {
      /*rawdata alındı*/
      Map<String, dynamic>? rawData = await tableDataHandler.getRawData();
      List<dynamic> itemsToRemove = [];

      if (rawData != null) {
        for (var table in rawData["tables"]) {
          if (table["tableNum"] == tableNum) {
            print("içinde bulunuduğumuz masa $table \n*\n");
            /*    doğru masadayız   */

            for (var order in table["orders"]) {
              /* table orderdaki her table itemi için */

              for (var removeItem in removeList.entries) {
                if (removeItem.key == order["name"]) {
                  print("#####$order");

                  double orderPrice = order["price"] / order["quantity"];

                  order["quantity"] = order["quantity"] - removeItem.value;

                  order["price"] =
                      order["price"] - (orderPrice * removeItem.value);

                  table["totalPrice"] =
                      table["totalPrice"] - (orderPrice * removeItem.value);

                  if (order["quantity"] == 0) {
                    itemsToRemove.add(order);
                  }
                }
              }
            }

            for (var itemToRemove in itemsToRemove) {
              table["orders"].remove(itemToRemove);
            }
          }
        }

        await tableDataHandler.writeJsonData(jsonEncode(rawData));

        /*üst kısımda bir hata çıkarsa*/
      } else {
        print("rawData is null");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
    print("writeTable başarı ile tamamlandı");
  }
}