import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class AnalysesReader {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = join(await _localPath, 'analyses.json');
    return File(path);
  }

  Future<Map<String, dynamic>?> getRawData() async {
    try {
      final file = await _localFile;

      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          return jsonDecode(content);
        }
      }
    } catch (e) {
      print('Analyses data read error: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getDaySet(int day, int month, int year) async {
    String date = "$day.$month.$year";
    Map<String, dynamic>? rawData = await getRawData();

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

  Future<void> writeJsonData(String jsonData) async {
    final file = await _localFile;
    try {
      await file.writeAsString(jsonData);
      print("Başarılı");
    } catch (e) {
      print('JSON data write error: $e');
    }
  }

  Future<Map<String, int>?> getDailyProductSales(int day, int month, int year) async {
    String date = "$day.$month.$year";
    Map<String, dynamic>? rawData = await getRawData();

    if (rawData != null && rawData.containsKey("sales")) {
      Map<String, dynamic> salesData = rawData["sales"];
      if (salesData.containsKey(date)) {
        Map<String, dynamic> dayData = salesData[date];
        if (dayData.containsKey("products")) {
          Map<String, dynamic> products = dayData["products"];
          Map<String, int> dailySales = {};
          products.forEach((key, value) {
            dailySales[key] = value["quantity"];
          });
          return dailySales;
        } else {
          print("Belirtilen tarihe ait ürün verisi bulunamadı.");
          return null;
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

  Future<Map<int, Map<String, int>>?> getWeeklyProductSalesForMonth(int month, int year, {bool splitIntoWeeks = false}) async {
    Map<int, Map<String, int>> monthlySales = {};

    // İlgili ayın ilk günü ve son günü
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate = DateTime(year, month + 1, 1).subtract(Duration(days: 1));

    for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(Duration(days: 1))) {
      int weekNumber = splitIntoWeeks ? (date.day / 7).ceil() : 1; // splitIntoWeeks true ise haftalara bölecek, false ise 1 olarak ayarlanacak
      int day = date.day;
      int month = date.month;
      int year = date.year;

      Map<String, int>? dailySales = await getDailyProductSales(day, month, year);
      if (dailySales != null) {
        // Haftalık satışları güncelle
        if (!monthlySales.containsKey(weekNumber)) {
          monthlySales[weekNumber] = {};
        }
        dailySales.forEach((product, quantity) {
          monthlySales[weekNumber]!.update(product, (value) => value + quantity, ifAbsent: () => quantity);
        });
      }
    }

    return monthlySales.isNotEmpty ? monthlySales : null;
  }

  Future<Map<String, dynamic>?> getWeeklyTotalRevenueForMonth(int month, int year, {bool splitIntoWeeks = false}) async {
    Map<String, dynamic> monthlyRevenue = {};

    // İlgili ayın ilk günü ve son günü
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate = DateTime(year, month + 1, 1).subtract(Duration(days: 1));

    double totalRevenue = 0.0;

    int currentWeek = 1;

    for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(Duration(days: 1))) {
      int weekNumber = splitIntoWeeks ? (date.day / 7).ceil() : 1;
      int day = date.day;

      if (weekNumber != currentWeek) {
        // Yeni hafta başladı, toplam geliri sıfırla
        if (splitIntoWeeks) {
          monthlyRevenue[currentWeek.toString()] = totalRevenue;
        }
        totalRevenue = 0.0;
        currentWeek = weekNumber;
      }

      double dayRevenue = await getDaysTotalRevenue(day, month, year);
      if (dayRevenue != -1.0) {
        totalRevenue += dayRevenue;
      }

      if (!splitIntoWeeks && date == endDate) {
        // Son gün ve haftalara bölmüyoruz, toplamı ekle
        monthlyRevenue["1"] = totalRevenue;
      }
    }

    return monthlyRevenue.isNotEmpty ? monthlyRevenue : null;
  }

  Future<Map<String, double>> getDailyTotalRevenueForMonth(int month, int year) async {
    Map<String, double> dailyTotalRevenue = {};

    // İlgili ayın ilk günü ve son günü
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate = DateTime(year, month + 1, 1).subtract(Duration(days: 1));

    for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(Duration(days: 1))) {
      int day = date.day;
      int month = date.month;
      int year = date.year;

      double dayRevenue = await getDaysTotalRevenue(day, month, year);
      if (dayRevenue != -1.0) {
        dailyTotalRevenue["$day.$month.$year"] = dayRevenue;
      }
    }

    return dailyTotalRevenue.isNotEmpty ? dailyTotalRevenue : {};
  }

}
