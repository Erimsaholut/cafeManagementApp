import 'dart:convert';

import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';

class WriteTableData {
  TableDataHandler tableDataHandler = TableDataHandler();
  ResetTableDatas resetTableDatas = ResetTableDatas();

  Future<void> addItemToTable(
      int tableNum, String itemName, int quantity, int price) async {
    Map<String, dynamic>? rawData = await tableDataHandler.getRawData();

    if (rawData != null) {
      Map<String, dynamic> newItem = {
        "name": itemName,
        "quantity": quantity,
        "price": price,
      };

      for (var i in rawData["tables"]) {
        if (i["tableNum"] == tableNum) {
          i["orders"].add(newItem);
        }
      }

      num totalPrice = 0;
      for (var i in rawData["tables"]) {
        i["totalPrice"] = i["orders"].fold(0, (sum, order) => sum + order["price"]);
        totalPrice += i["totalPrice"];
      }

      for (var i in rawData["tables"]) {
        if (i["tableNum"] == tableNum) {
          i["totalPrice"] = totalPrice;
        }
      }
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
