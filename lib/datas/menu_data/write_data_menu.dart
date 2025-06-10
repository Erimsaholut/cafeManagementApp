import 'package:adisso/datas/menu_data/read_data_menu.dart';
import 'package:adisso/datas/menu_data/reset_datas_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WriteMenuData {
  ReadMenuData readData = ReadMenuData();
  ResetMenuDatas demoMenuDatas = ResetMenuDatas();
  RemoveMenuDatas removeMenuDatas = RemoveMenuDatas();

  Future<void> setCafeName(String newCafeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString('cafeName', newCafeName);
      print("cafeName");
      print(prefs.getString('cafeName'));
    } catch (e) {
      print('Cafe adı güncellenirken hata oluştu: $e');
    }
  }

  Future<void> setTableCount(int newTableCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setInt('tableCount', newTableCount);
      int? tableCount = prefs.getInt('tableCount');
      print(tableCount);
    } catch (e) {
      print('Masa sayısı güncellenirken hata oluştu: $e');
    }
  }

  Future<void> resetToDemoMenu() async {
    try {
      Map<String, dynamic> initialMenu = demoMenuDatas.jsonMenuDemoData;
      await readData.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile resetlendi");
    } catch (e) {
      print("Resetlenemedi $e");
    }
  }

  Future<void> resetToBlankMenu() async {
    try {
      Map<String, dynamic> initialMenu = removeMenuDatas.jsonMenuResetData;
      await readData.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile sıfırlandı");
    } catch (e) {
      print("Resetlenemedi $e");
    }
  }

  Future<bool?> addNewItemToMenu(String itemName, int moneyValue,
      int pennyValue, List<String> indList, String type,
      {double profit = 0}) async {

    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        List<dynamic> menu = rawData["menu"];

        String lowercaseItemName = itemName.toLowerCase();
        bool itemExists =
        menu.any((item) => item["name"].toLowerCase() == lowercaseItemName);

        if (itemExists) {
          print(
              "Bu ürün zaten mevcut. Lütfen ürünü kontrol edin veya mevcut ürünün adını değiştirin.");
          return false;
        }

        Map<String, dynamic> newItem = {
          "name": itemName,
          "price": moneyValue + pennyValue / 100,
          "profit": profit,
          "type": type,
          "ingredients": indList,
        };

        menu.add(newItem);

        await readData.writeJsonData(json.encode(rawData));
        print("Yeni ürün başarıyla eklendi: $itemName");
        readData.readJsonData();
        readData.separateMenuItems();
        return true;
      }
    } catch (e) {
      print('Yeni ürün eklenirken hata oluştu: $e');
      return false;
    }

    return null;
  }

  Future<void> setExistingItemInMenu(String itemName, int newPriceMoney,
      int newPricePenny, List<String> indList,String type,
      {double newProfit = 0}) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        List<dynamic> menu = rawData["menu"];

        Map<String, dynamic>? oldItem;

        // eski itemi bulup kaldır
        int index = menu.indexWhere((item) => item["name"] == itemName);
        if (index != -1) {
          oldItem = menu[index];
          menu.removeAt(index);
        }

        if (oldItem != null) {
          print("oldItem:$oldItem");
          print("$newPriceMoney ve $newPricePenny");
          print("newMoney :${newPriceMoney + (newPricePenny / 100)}");

          Map<String, dynamic> newItem = {
            "name": itemName,
            "price": newPriceMoney + newPricePenny / 100,
            "profit": newProfit,
            "type": type,
            "ingredients": indList,
          };
          print("newItem:$newItem");
          print(newItem);

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

  Future<void> removeItemFromMenu(String itemName) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        List<dynamic> menu = rawData["menu"];

        menu.removeWhere((item) => item["name"] == itemName);

        await readData.writeJsonData(json.encode(rawData));
        print("Ürün başarıyla silindi: $itemName");
        readData.readJsonData();
        readData.separateMenuItems();
      }
    } catch (e) {
      print('Ürün silinirken hata oluştu: $e');
    }
  }

  Future<void> addCategory(String categoryName) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();
      if (rawData != null) {
        List<dynamic> categories = rawData["categories"];

        // Check if the category already exists
        bool categoryExists = categories.contains(categoryName);
        if (categoryExists) {
          print("Bu kategori zaten mevcut.");
          return;
        }

        // Add the new category
        categories.add(categoryName);

        await readData.writeJsonData(json.encode(rawData));
        print("Yeni kategori başarıyla eklendi: $categoryName");
      }
    } catch (e) {
      print('Kategori eklenirken hata oluştu: $e');
    }
  }

  Future<void> removeCategory(String categoryName) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();
      if (rawData != null) {
        List<dynamic> categories = rawData["categories"];

        // Remove the category if it exists
        categories.remove(categoryName);

        await readData.writeJsonData(json.encode(rawData));
        print("Kategori başarıyla silindi: $categoryName");
      }
    } catch (e) {
      print('Kategori silinirken hata oluştu: $e');
    }
  }

}

//todo diğer ürünlerdeki kategoriler zorunlu tutulmasın
