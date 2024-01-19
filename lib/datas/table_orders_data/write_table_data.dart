import 'dart:convert';

import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';

class WriteTableData {
  int tableNum;

  WriteTableData(this.tableNum);

  Future<void> addItemToTable(
      String itemName, int quantity, int price) async {
    try {
      TableDataHandler tableDataHandler = TableDataHandler(tableNum);
      Map<String, dynamic>? rawData = await tableDataHandler.getRawData();

      if (rawData != null) {
        // Yeni öğeyi oluştur
        Map<String, dynamic> newItem = {
          "name": itemName,
          "quantity": quantity,
          "price": price,
        };

        // "orders" listesine yeni öğeyi ekle
        rawData["orders"].add(newItem);

        // Yeni toplam fiyatı hesapla
        int totalPrice = rawData["orders"].fold<int>(
          0,
              (int sum, order) =>
          sum + (order['price'] * order['quantity']) as int,
        );

        // Toplam fiyatı güncelle
        rawData["totalPrice"] = totalPrice;

        // JSON verisini güncelle
        await tableDataHandler.writeJsonData(json.encode(rawData));
        print("Item added successfully.");
      }
    } catch (e) {
      print('Error adding item: $e');
    }
  }
}
