import 'dart:convert';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/reset_datas.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data.dart';

class WriteData {
  ReadData readData = ReadData();
  ResetDatas resetDatas = ResetDatas();

  Future<void> _updateSettingsInJSON(

      String newCafeName, int newTableCount) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        rawData["cafe_name"] = newCafeName;
        rawData["table_count"] = newTableCount;

        await readData.writeJsonData(json.encode(rawData));
        print("Settings updated successfully.");
      }
    } catch (e) {
      print('Settings güncellenirken hata oluştu: $e');
    }
  }

  Future<void> setCafeName(String newCafeName) async {
    Map<String, dynamic>? rawData = await readData.getRawData();
    int currentTableCount = rawData?["table_count"] ?? 0;
    try {
      await _updateSettingsInJSON(newCafeName, currentTableCount);
    } catch (e) {
      print('Cafe adı güncellenirken hata oluştu: $e');
    }
  }

  Future<void> setTableCount(int newTableCount) async {
    Map<String, dynamic>? rawData = await readData.getRawData();
    String currentCafeName = rawData?["cafe_name"] ?? "";
    try {
      await _updateSettingsInJSON(currentCafeName, newTableCount);
    } catch (e) {
      print('Cafe adı güncellenirken hata oluştu: $e');
    }
  }

  Future<void> resetData() async {

    try {
      Map<String, dynamic> initialMenu = resetDatas.jsonRawDataFirst;
      await readData.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile resetlendi");
    } catch (e) {
      print("Resetlenemedi $e");
    }

  }

  Future<void> addNewItemToMenu(String itemName, int moneyValue,
      int pennyValue, List<String> indList, String type) async {
    if (type == "Yiyecek") {
      type = "food";
    }
    if (type == "İçecek") {
      type = "drink";
    }

    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        List<dynamic> menu = rawData["menu"];

        int newId = _generateNewItemId(menu);

        Map<String, dynamic> newItem = {
          "id": newId,
          "name": itemName,
          "price": moneyValue + pennyValue / 100,
          "type": type,
          "ingredients": indList,
        };

        menu.add(newItem);

        await readData.writeJsonData(json.encode(rawData));
        print("Yeni ürün başarıyla eklendi: $itemName");
        readData.readJsonData();
        readData.separateMenuItems();
      }
    } catch (e) {
      print('Yeni ürün eklenirken hata oluştu: $e');
    }
  }

  Future<void> setExistingItemInMenu(String itemName, double moneyValue, int pennyValue, List<String> indList) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        List<dynamic> menu = rawData["menu"];
        Map<String, dynamic>? oldItem;

        for (var item in menu) {
          if (item["name"] == itemName) {
            oldItem = item;
            menu.remove(item);
            break;
          }
        }

        if (oldItem != null) {
          Map<String, dynamic> newItem = {
            "id": oldItem["id"],
            "name": itemName,
            "price": moneyValue + pennyValue / 100,
            "type": oldItem["type"],
            "ingredients": indList,
          };

          menu.add(newItem);

          await readData.writeJsonData(json.encode(rawData));

          print("Ürün başarıyla güncellendi: $itemName");

          readData.readJsonData();
          readData.separateMenuItems();
        } else {
          print("Güncellenecek ürün bulunamadı: $itemName");
        }
      }
    } catch (e) {
      print('Ürün güncellenirken hata oluştu: $e');
    }
  }

  int _generateNewItemId(List<dynamic> menu) {
    int maxId = 0;

    for (var item in menu) {
      int itemId = item["id"];
      if (itemId > maxId) {
        maxId = itemId;
      }
    }

    return maxId + 1;
  }


}
