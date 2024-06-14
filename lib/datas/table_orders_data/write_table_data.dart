import 'dart:convert';
import 'package:adisso/datas/table_orders_data/read_table_data.dart';
import 'package:adisso/datas/table_orders_data/reset_table_datas.dart';
import '../analyses_data/write_data_analyses.dart';

class WriteTableData {
  final WriteAnalysesData writeAnalysesData = WriteAnalysesData();
  final ResetTableDatas resetTableDatas = ResetTableDatas();
  final TableReader tableDataHandler = TableReader();

  Future<void> addItemToTable(int tableNum, String itemName, int quantity, double price) async {
    try {
      final rawData = await tableDataHandler.getRawData();

      if (rawData != null) {
        final table = _findTable(rawData, tableNum);
        if (table != null) {
          final order = _findOrder(table, itemName);
          if (order != null) {
            _updateExistingOrder(order, quantity, price);
          } else {
            _addNewOrder(table, itemName, quantity, price);
          }
          table["totalPrice"] += price;
          await tableDataHandler.writeJsonData(jsonEncode(rawData));
        }
      }
    } catch (e) {
      print('Error adding new item: $e');
    }
  }

  Future<void> resetAllData() async {
    try {
      resetTableDatas.createTables(22);
      await tableDataHandler.writeJsonData(jsonEncode(resetTableDatas.jsonRawDataFirst));
      print("Successfully reset all data.");
    } catch (e) {
      print("Failed to reset all data: $e");
    }
  }

  Future<void> resetOneTable(int tableNum) async {
    try {
      final rawData = await tableDataHandler.getRawData();

      if (rawData != null) {
        final table = _findTable(rawData, tableNum);
        if (table != null) {
          table["totalPrice"] = 0.0;
          table["orders"] = [];
          await tableDataHandler.writeJsonData(jsonEncode(rawData));
          print("Successfully reset table $tableNum.");
        }
      }
    } catch (e) {
      print("Failed to reset table $tableNum: $e");
    }
  }

  Future<void> decreaseItemList(int tableNum, Map<String, int> removeList) async {
    try {
      final rawData = await tableDataHandler.getRawData();

      if (rawData != null) {
        final table = _findTable(rawData, tableNum);
        if (table != null) {
          _decreaseOrders(table, removeList);
          await tableDataHandler.writeJsonData(jsonEncode(rawData));
        }
      } else {
        print("rawData is null");
      }
    } catch (e) {
      print("Error decreasing items: $e");
    }
    print("Successfully decreased items.");
  }

  Map<String, dynamic>? _findTable(Map<String, dynamic> rawData, int tableNum) {
    return rawData["tables"].firstWhere((table) => table["tableNum"] == tableNum, orElse: () => null);
  }

  Map<String, dynamic>? _findOrder(Map<String, dynamic> table, String itemName) {
    return table["orders"].firstWhere((order) => order["name"] == itemName, orElse: () => null);
  }

  void _addNewOrder(Map<String, dynamic> table, String itemName, int quantity, double price) {
    final newItem = {
      "name": itemName,
      "quantity": quantity,
      "price": price,
    };
    table["orders"].add(newItem);
  }

  void _updateExistingOrder(Map<String, dynamic> order, int quantity, double price) {
    order["quantity"] += quantity;
    order["price"] += price;
  }

  void _decreaseOrders(Map<String, dynamic> table, Map<String, int> removeList) {
    final itemsToRemove = [];

    for (final order in table["orders"]) {
      final itemName = order["name"];
      if (removeList.containsKey(itemName)) {
        final quantityToRemove = removeList[itemName]!;
        final pricePerUnit = order["price"] / order["quantity"];

        order["quantity"] -= quantityToRemove;
        order["price"] -= pricePerUnit * quantityToRemove;
        table["totalPrice"] -= pricePerUnit * quantityToRemove;

        if (order["quantity"] <= 0) {
          itemsToRemove.add(order);
        }
      }
    }

    table["orders"].removeWhere((order) => itemsToRemove.contains(order));
  }
}
