import 'dart:convert';

import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_data.dart';

class WriteData {
  ReadData readData = ReadData();

  Future<void> _updateSettingsInJSON(String newCafeName,
      int newTableCount) async {
    try {
      Map<String, dynamic>? rawData = await readData.getRawData();

      if (rawData != null) {
        rawData["cafe_name"] = newCafeName;
        rawData["table_count"] = newTableCount;

        await readData.writeJsonData(rawData.toString());
        print("Settings updated successfully.");
      }
    } catch (e) {
      print('Settings güncellenirken hata oluştu: $e');
    }
  }

  Future<void> setCafeName(String newCafeName) async {
    Map<String, dynamic>? rawData = await readData.getRawData();
    int currentTableCount = rawData?["table_count"] ?? 0;
    await _updateSettingsInJSON(newCafeName, currentTableCount);
    print(readData.getRawData()); // test amaçlı hep
  }

  Future<void> setTableCount(int newTableCount) async {
    Map<String, dynamic>? rawData = await readData.getRawData();
    String currentCafeName = rawData?["cafe_name"] ?? "";
    await _updateSettingsInJSON(currentCafeName, newTableCount);
    print(readData.getRawData()); // test amaçlı hep
  }

  Future<void> resetData() async {
    try {
      Map<String, dynamic> initialMenu = {

        "cafe_name": "Çamaltı Kahvehanesi",
        "table_count": 22,
        "menu": [
          {
            "id": 1,
            "name": "Çay",
            "price": 5,
            "type": "drink",
            "ingredients": []
          },
          {
            "id": 2,
            "name": "Su",
            "price": 5,
            "type": "drink",
            "ingredients": []
          },
          {
            "id": 3,
            "name": "Ayran",
            "price": 10,
            "type": "drink",
            "ingredients": []
          },
          {
            "id": 4,
            "name": "Limonata",
            "price": 15,
            "type": "drink",
            "ingredients": []
          },
          {
            "id": 5,
            "name": "Kefir",
            "price": 20,
            "type": "drink",
            "ingredients": []
          },
          {
            "id": 6,
            "name": "Nescafe",
            "price": 10,
            "type": "drink",
            "ingredients": [
              "Sade",
              "İkisi bir arada",
              "Üçü Bir arada"
            ]
          },
          {
            "id": 7,
            "name": "Türk Kahvesi",
            "price": 20,
            "type": "drink",
            "ingredients": [
              "Sade",
              "Az Şekerli",
              "Orta Şekerli",
              "Şekerli"
            ]
          },
          {
            "id": 8,
            "name": "Oralet",
            "price": 5,
            "type": "drink",
            "ingredients": [
              "Portakal",
              "Limon",
              "Kivi",
              "Muz"
            ]
          },
          {
            "id": 9,
            "name": "Sucuklu Tost",
            "price": 45,
            "type": "food",
            "ingredients": [
              "Ketçap",
              "Mayonez",
              "Soğan",
              "Yeşillik",
              "Turşu"
            ]
          },
          {
            "id": 10,
            "name": "Tavuk Döner",
            "price": 6.99,
            "type": "food",
            "ingredients": [
              "Ketçap",
              "Mayonez",
              "Soğan",
              "Turşu"
            ]
          },
          {
            "id": 11,
            "name": "Kokoreç",
            "price": 5.49,
            "type": "food",
            "ingredients": [
              "Acı",
              "Kimyon",
              "Kekik"
            ]
          },
          {
            "id": 12,
            "name": "Ekmek",
            "price": 7,
            "type": "food",
            "ingredients": []
          }
        ]
      };
      await readData.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile resetlendi");
    }
    catch(e){
      print("Resetlenemedi $e");
    }
    }
  }
