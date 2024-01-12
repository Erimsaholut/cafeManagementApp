import 'dart:convert';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/reset_datas.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_data.dart';


class WriteData {
  ReadData readData = ReadData();
  ResetDatas resetDatas = ResetDatas();

  Future<void> _updateSettingsInJSON(String newCafeName,
      int newTableCount) async {
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
    await _updateSettingsInJSON(newCafeName, currentTableCount);
  }

  Future<void> setTableCount(int newTableCount) async {
    Map<String, dynamic>? rawData = await readData.getRawData();
    String currentCafeName = rawData?["cafe_name"] ?? "";
    await _updateSettingsInJSON(currentCafeName, newTableCount);
  }

  Future<void> resetData() async {
    try {
      Map<String, dynamic> initialMenu = resetDatas.jsonRawDataFirst;
      await readData.writeJsonData(jsonEncode(initialMenu));
      print("Başarı ile resetlendi");
    }
    catch(e){
      print("Resetlenemedi $e");
    }
    }
  }
