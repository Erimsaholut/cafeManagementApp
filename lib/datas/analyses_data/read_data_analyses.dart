import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class AnalysesReader {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localDailyFile async {
    final path = join(await _localPath, 'analyses.json');
    return File(path);
  }

  Future<File> get _localMonthlyFile async {
    final path = join(await _localPath, 'analysesMonth.json');
    return File(path);
  }

  Future<File> get _localYearlyFile async {
    final path = join(await _localPath, 'analysesYear.json');
    return File(path);
  }

  Future<File?> selectFileDataType(int code) async {
    try {
      late File file; // File nesnesini burada tanımlayın

      if (code == 0) {
        file = await _localDailyFile;
      } else if (code == 1) {
        file = await _localMonthlyFile;
      } else if (code == 2) {
        file = await _localYearlyFile;
      } else {
        throw ArgumentError('Geçersiz kod: $code');
      }

      return file;
    } catch (e) {
      print('Veri okuma hatası: $e');
      return null; // Hata durumunda null döndürün
    }
  }

  Future<Map<String, dynamic>?> getRawData(int code) async {
    try {
      final file = await selectFileDataType(code); // selectFileDataType metodunu await ile çağırın ve sonucu alın

      if (file != null && await file.exists()) { // file null değilse ve varsa
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          return jsonDecode(content);
        }
      }
    } catch (e) {
      print('Veri okuma hatası: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getDaySet(int day, int month, int year) async {
    String date = "$day.$month.$year";
    Map<String, dynamic>? rawData = await getRawData(0);

    if (rawData != null && rawData.containsKey("sales")) {
      Map<String, dynamic> salesData = rawData["sales"];
      if (salesData.containsKey(date)) {
        return salesData[date];
      } else {
        print("Belirtilen tarihe ait satış verisi bulunamadı.");
        return null;
      }
    } else {
      print("Satış verileri bulunamadı veya işlenemedi.");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMonthSet(int month, int year) async {
    String date = "$month.$year";
    Map<String, dynamic>? rawData = await getRawData(1);

    if (rawData != null && rawData.containsKey("sales")) {
      Map<String, dynamic> salesData = rawData["sales"];
      if (salesData.containsKey(date)) {
        return salesData[date];
      } else {
        print("Belirtilen tarihe ait satış verisi bulunamadı.");
        return null;
      }
    } else {
      print("Satış verileri bulunamadı veya işlenemedi.");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getYearSet(int year) async {
    String date = "$year";
    Map<String, dynamic>? rawData = await getRawData(2);

    if (rawData != null && rawData.containsKey("sales")) {
      Map<String, dynamic> salesData = rawData["sales"];
      if (salesData.containsKey(date)) {
        return salesData[date];
      } else {
        print("Belirtilen tarihe ait satış verisi bulunamadı.");
        return null;
      }
    } else {
      print("Satış verileri bulunamadı veya işlenemedi.");
      return null;
    }
  }

  Future<double> getDaysTotalRevenue(int day, int month, int year) async {
    double totalRevenue = 0.0;
    Map<String, dynamic>? daySet = await getDaySet(day, month, year);

    if (daySet != null && daySet.containsKey("products")) {
      Map<String, dynamic> products = daySet["products"];
      products.forEach((key, value) {
        totalRevenue += value["revenue"];
      });
      return totalRevenue;
    } else {
      print("Belirtilen tarihe ait satış verisi bulunamadı veya işlenemedi.");
      return -1.0;
    }
  }

  Future<double> getMonthsTotalRevenue(int month, int year) async {
    double totalRevenue = 0.0;
    Map<String, dynamic>? daySet = await getMonthSet(month, year);

    if (daySet != null && daySet.containsKey("products")) {
      Map<String, dynamic> products = daySet["products"];
      products.forEach((key, value) {
        totalRevenue += value["revenue"];
      });
      return totalRevenue;
    } else {
      print("Belirtilen tarihe ait satış verisi bulunamadı veya işlenemedi.");
      return -1.0;
    }
  }

  Future<double> getYearsTotalRevenue(int year) async {
    double totalRevenue = 0.0;
    Map<String, dynamic>? daySet = await getYearSet(year);

    if (daySet != null && daySet.containsKey("products")) {
      Map<String, dynamic> products = daySet["products"];
      products.forEach((key, value) {
        totalRevenue += value["revenue"];
      });
      return totalRevenue;
    } else {
      print("Belirtilen tarihe ait satış verisi bulunamadı veya işlenemedi.");
      return -1.0;
    }
  }


  Future<void> writeJsonData(String jsonData, int code) async {
    final file = await selectFileDataType(code);

    try {
      await file?.writeAsString(jsonData);
      print("Başarılı");
    } catch (e) {
      print('JSON data write error: $e');
    }
  }

  /*belirli bir günün verilerini alıyor*/
  Future<Map<String, int>?> getProductSalesForOneDay(
      int day, int month, int year) async {
    String date = "$day.$month.$year";
    Map<String, dynamic>? rawData = await getRawData(0);

    if (rawData != null && rawData.containsKey("sales")) {

      Map<String, dynamic> salesData = rawData["sales"];
      Map<String, int> dailySales = {};

      if (salesData.containsKey(date)) {
        Map<String, dynamic> dayData = salesData[date];
        if (dayData.containsKey("products")) {
          Map<String, dynamic> products = dayData["products"];

          products.forEach((key, value) {
            dailySales[key] = value["quantity"];
          });
          return dailySales;
        } else {
          print("Belirtilen tarihe ait ürün verisi bulunamadı.");
          return dailySales;
        }
      } else {
        print("Belirtilen tarihe ait satış verisi bulunamadı.");
        return null;
      }
    } else {
      print("Satış verileri bulunamadı veya işlenemedi.");
      return null;
    }
  }

  /*bunu 30 kere çalıştırıp 1 ay için günlük veri alıyor*/
  Future<Map<int, Map<String, int>>?> getWeeklyProductSalesForMonth(
      int month, int year,
      {bool splitIntoWeeks = false}) async {
    Map<int, Map<String, int>> monthlySales = {};

    // İlgili ayın ilk günü ve son günü
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

    for (DateTime date = startDate;
    date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
    date = date.add(const Duration(days: 1))) {
      int weekNumber = splitIntoWeeks
          ? (date.day / 7).ceil()
          : 1; // splitIntoWeeks true ise haftalara bölecek, false ise 1 olarak ayarlanacak
      int day = date.day;
      int month = date.month;
      int year = date.year;

      Map<String, int>? dailySales =
      await getProductSalesForOneDay(day, month, year);
      if (dailySales != null) {
        // Haftalık satışları güncelle
        if (!monthlySales.containsKey(weekNumber)) {
          monthlySales[weekNumber] = {};
        }
        dailySales.forEach((product, quantity) {
          monthlySales[weekNumber]!.update(product, (value) => value + quantity,
              ifAbsent: () => quantity);
        });
      }
    }

    return monthlySales.isNotEmpty ? monthlySales : {};
  }
  //üstteki ikisi piechart için veri sağlıyor


/*30 kere çalıştırmak yerine direkt aylık veri dosyasından okuyacak*/
  Future<Map<String, int>?> testAylikItemAdetleri(int month, int year) async {
    String date = "$month.$year";
    Map<String, dynamic>? rawData = await getRawData(1);



    if (rawData != null && rawData.containsKey("sales")) {

      Map<String, dynamic> salesData = rawData["sales"];
      Map<String, int> monthlySales = {};

      if (salesData.containsKey(date)) {


        Map<String, dynamic> monthData = salesData[date];
        if (monthData.containsKey("products")) {
          Map<String, dynamic> products = monthData["products"];

          products.forEach((key, value) {
            monthlySales[key] = value["quantity"];
          });
          return monthlySales;
        } else {
          print("Belirtilen tarihe ait ürün verisi bulunamadı.");
          return monthlySales;
        }
      }








      else {
        print("Belirtilen tarihe ait satış verisi bulunamadı.");
        return null;
      }
    }






    else {
      print("Satış verileri bulunamadı veya işlenemedi.");
      return null;
    }
  }




  Future<Map<String, double>> getDailyTotalRevenueForMonth(
      int month, int year) async {
    Map<String, double> dailyTotalRevenue = {};

    // İlgili ayın ilk günü ve son günü
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

    for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(const Duration(days: 1))) {
      int day = date.day;
      int month = date.month;
      int year = date.year;

      double dayRevenue = await getDaysTotalRevenue(day, month, year);
      if (dayRevenue != -1.0) {
        dailyTotalRevenue["$day.$month.$year"] = dayRevenue;
      }else{
        dailyTotalRevenue["$day.$month.$year"] = 0.0;
      }

    }

    return dailyTotalRevenue.isNotEmpty ? dailyTotalRevenue : {};
  }

  Future<Map<String, double>> getMonthlyTotalRevenueForYear(int year) async {
    Map<String, double> monthlyTotalRevenue = {};

    for (int month = 1; month <= 12; month++) {
      double monthRevenue = await getMonthsTotalRevenue(month, year);
      if (monthRevenue != -1.0) {
        monthlyTotalRevenue["$month.$year"] = monthRevenue;
      }else{
        monthlyTotalRevenue["$month.$year"] = 0.0;
      }
    }

    return monthlyTotalRevenue.isNotEmpty ? monthlyTotalRevenue : {};
  }

  Future<Map<String, double>> getYearlyTotalRevenueForYear(int year) async {
    Map<String, double> yearlyTotalRevenue = {};

      double yearRevenue = await getYearsTotalRevenue(year);
      if (yearRevenue != -1.0) {
        yearlyTotalRevenue["$year"] = yearRevenue;
      }else{
        yearlyTotalRevenue["$year"] = 0.0;
      }
    return yearlyTotalRevenue.isNotEmpty ? yearlyTotalRevenue : {};
  }
  //todo bunu iki yıl için karşılaştırmalı olarak yapabilirin

//üstteki linechart için veri sağlıyor

}
