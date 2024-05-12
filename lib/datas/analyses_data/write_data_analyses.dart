import 'dart:convert';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';

class WriteAnalysesData {
  AnalysesReader analysesDataHandler = AnalysesReader();
  ReadMenuData readData = ReadMenuData();

  /*bu çavo buraya salladı direkt*/
  addItemToAnalysesJson(String prodName,int prodQuantity) async{
    await addItemToDailyAnalysesJson(prodName,prodQuantity);
    await addItemToMonthlyAnalysesJson(prodName,prodQuantity);
    await addItemToYearlyAnalysesJson(prodName,prodQuantity);
  }

  Future<void> addItemToDailyAnalysesJson(String prodName,
      int prodQuantity) async {
    try {
      Map<String, dynamic>? rawData = await analysesDataHandler.getRawData(0);
      double prodPrice = await readData.getItemPrice(prodName);
      double profitValue = await readData.getItemProfit(prodName);


      DateTime date = DateTime.now();
      String dateNow = "${date.day}.${date.month}.${date.year}";

      if (rawData != null) {
        if (!rawData.containsKey("sales")) {
          rawData["sales"] = {};
        }

        if (!rawData["sales"].containsKey(dateNow)) {
          rawData["sales"][dateNow] = {"products": {}};
        }

        if (!rawData["sales"][dateNow]["products"].containsKey(prodName)) {
          rawData["sales"][dateNow]["products"][prodName] = {
            "quantity": prodQuantity,
            "revenue": prodPrice * prodQuantity,
            "profit": profitValue * prodQuantity
          };
        } else {
          rawData["sales"][dateNow]["products"][prodName]["quantity"] += prodQuantity;
          rawData["sales"][dateNow]["products"][prodName]["revenue"] += prodPrice * prodQuantity;
        }

        await analysesDataHandler.writeJsonData(jsonEncode(rawData),0);
      }
    } catch (e) {
      print('Ürün analizi eklenirken hata oluştu: $e');
    }
  }


  /*monthlyde sıkıntı yok ama diğerlerinde var*/
  Future<void> addItemToMonthlyAnalysesJson(String prodName,
      int prodQuantity) async {
    try {
      Map<String, dynamic>? rawData = await analysesDataHandler.getRawData(1);
      double prodPrice = await readData.getItemPrice(prodName);
      double profitValue = await readData.getItemProfit(prodName);


      DateTime date = DateTime.now();
      String dateNow = "${date.month}.${date.year}";

      if (rawData != null) {

        if (!rawData.containsKey("sales")) {
          rawData["sales"] = {};
        }

        if (!rawData["sales"].containsKey(dateNow)) {
          rawData["sales"][dateNow] = {"products": {}};
        }

        if (!rawData["sales"][dateNow]["products"].containsKey(prodName)) {
          rawData["sales"][dateNow]["products"][prodName] = {
            "quantity": prodQuantity,
            "revenue": prodPrice * prodQuantity,
            "profit": profitValue * prodQuantity
          };
        } else {
          rawData["sales"][dateNow]["products"][prodName]["quantity"] += prodQuantity;
          rawData["sales"][dateNow]["products"][prodName]["revenue"] += prodPrice * prodQuantity;
        }
        await analysesDataHandler.writeJsonData(jsonEncode(rawData),1);
      }
    } catch (e) {
      print('Ürün analizi eklenirken hata oluştu: $e');
    }
  }


  Future<void> addItemToYearlyAnalysesJson(String prodName,
      int prodQuantity) async {
    try {
      Map<String, dynamic>? rawData = await analysesDataHandler.getRawData(2);
      double prodPrice = await readData.getItemPrice(prodName);
      double profitValue = await readData.getItemProfit(prodName);


      DateTime date = DateTime.now();
      String dateNow = "${date.year}";

      if (rawData != null) {

        if (!rawData.containsKey("sales")) {
          rawData["sales"] = {};
        }

        if (!rawData["sales"].containsKey(dateNow)) {
          rawData["sales"][dateNow] = {"products": {}};
        }

        if (!rawData["sales"][dateNow]["products"].containsKey(prodName)) {
          rawData["sales"][dateNow]["products"][prodName] = {
            "quantity": prodQuantity,
            "revenue": prodPrice * prodQuantity,
            "profit": profitValue * prodQuantity
          };
        } else {
          rawData["sales"][dateNow]["products"][prodName]["quantity"] += prodQuantity;
          rawData["sales"][dateNow]["products"][prodName]["revenue"] += prodPrice * prodQuantity;
        }

        await analysesDataHandler.writeJsonData(jsonEncode(rawData),2);
      }
    } catch (e) {
      print('Ürün analizi eklenirken hata oluştu: $e');
    }
  }

}

//todo analyses data alırken isim alıp fiyatı kendi ekliyor ama profit de ekleyecek
//todo hatta analiz jsonuna profit kısmı ekle, türünü yerini belirleyip
