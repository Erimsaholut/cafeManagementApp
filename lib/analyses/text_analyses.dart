import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_utils.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datas/analyses_data/read_data_analyses.dart';
import '../datas/menu_data/read_data_menu.dart';
import 'package:flutter/material.dart';

class AnalysesAsAText extends StatefulWidget {
  const AnalysesAsAText({super.key});

  @override
  State<AnalysesAsAText> createState() => _AnalysesAsATextState();
}

class _AnalysesAsATextState extends State<AnalysesAsAText> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Text Analyses"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: FutureBuilder<List<Widget>>(
        future: getDatas(screenSize),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return snapshot.data![index];
              },
            );
          }
        },
      ),
    );
  }
}

// Asenkron olarak veri alınan fonksiyon
Future<List<Widget>> getDatas(Size size) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  AnalysesReader analysesReader = AnalysesReader();
  Map<String, double> monthMostProfit = {};
  ReadMenuData readData = ReadMenuData();
  Map<String, double> dayMostProfit = {};
  DateTime now = DateTime.now();
  List<String> monthTop3 = [];
  List<Widget> widgets = [];
  List<String> dayTop3 = [];
  bool isPremium = prefs.getBool("isPremium") ?? false;

  // Cafe ismi alınıyor, varsayılan isim belirleniyor
  String cafeName = prefs.getString('cafeName') ?? 'Default Cafe';
  int menuItemCount = await readData.getMenuItemCount();

  // Ayın verisi alınıyor, varsa en çok satılanlar ve en kârlılar sıralanıyor
  Map<String, dynamic>? wholeMonth =
      await analysesReader.getMonthSet(now.month, now.year);
  if (wholeMonth != null) {
    monthTop3 = getTop3Products(wholeMonth["products"]!);
    monthMostProfit = sortByProfit(wholeMonth);
  }

  // Günlük veri alınıyor, varsa en çok satılanlar ve en kârlılar sıralanıyor
  double monthlyProfit =
      await analysesReader.getMonthsTotalProfit(now.month, now.year);
  double monthlyRevenue =
      await analysesReader.getMonthsTotalRevenue(now.month, now.year);
  double dailyProfit =
      await analysesReader.getDaysTotalProfit(now.day, now.month, now.year);
  double dailyRevenue =
      await analysesReader.getDaysTotalRevenue(now.day, now.month, now.year);
  Map<String, dynamic>? wholeDay =
      await analysesReader.getDaySet(now.day, now.month, now.year);

  if (wholeDay != null) {
    dayTop3 = getTop3Products(wholeDay["products"]!);
    dayMostProfit = sortByProfit(wholeDay);
  }

  // Gerekli widget'lar oluşturuluyor
  widgets.add(
    Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        (isPremium)
            ? Expanded(
                child: customContainer(
                  size,
                  CustomColors.premiumColor,
                  "Premium Mode",
                ),
              )
            : Expanded(
                child: customContainer(
                  size,
                  CustomColors.trailColor,
                  "Deneme Sürümü",
                ),
              ),
        Expanded(
          flex: 4,
          child: customContainer(
            size,
            CustomColors.selectedColor7,
            cafeName,
          ),
        ),
        (isPremium)
            ? Expanded(
                child: customContainer(
                  size,
                  CustomColors.selectedColor8,
                  "Toplam Ürün Sayısı\n$menuItemCount",
                ),
              )
            : Expanded(
                child: customContainer(
                  size,
                  CustomColors.selectedColor8,
                  "Toplam Ürün Sayısı: $menuItemCount\n\nKalan ürün ekleme hakkı: ${30 - menuItemCount}",
                ),
              ),
      ],
    ),
  );

  if (wholeDay != null) {
    widgets.add(
      Row(
        children: [
          Expanded(
            flex: 4,
            child: customContainer(
              size,
              CustomColors.selectedColor6,
              "Bugün",
            ),
          ),
          Expanded(
            flex: 4,
            child: customContainer(
              size,
              CustomColors.selectedColor5,
              "En çok satılan ürünler",
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: (size.height / 3),
              color: CustomColors.selectedColor5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#1 ${dayTop3[0]}",
                      style: CustomTextStyles.blackAndBoldTextStyleM,
                    ),
                    Text(
                      "#2 ${dayTop3[1]}",
                      style: CustomTextStyles.blackAndBoldTextStyleM,
                    ),
                    Text(
                      "#3 ${dayTop3[2]}",
                      style: CustomTextStyles.blackAndBoldTextStyleM,
                    ),
                  ],
                ),
              ),
            ),
          ),
          (dayMostProfit.isNotEmpty)
              ? Expanded(
                  flex: 4,
                  child: customContainer(
                    size,
                    CustomColors.selectedColor6,
                    "Bu ayın \nen kârlı ürünü\n${dayMostProfit.keys.first}\n${dayMostProfit[dayMostProfit.keys.first]}₺",
                  ),
                )
              : Container(),
          Expanded(
            flex: 3,
            child: customContainer(
              size,
              CustomColors.selectedColor4,
              "Toplam Gelir\n$dailyRevenue",
            ),
          ),
          Expanded(
            flex: 3,
            child: customContainer(
              size,
              CustomColors.selectedColor3,
              "Toplam Kâr\n$dailyProfit",
            ),
          ),
        ],
      ),
    );
  } else {
    widgets.add(Row(
      children: [
        Expanded(
            child: customContainer(size, CustomColors.missingColor,
                "Bu Günün analizleri için yeterli veri bulunmamakta"))
      ],
    ));
  }

  if (wholeMonth != null) {
    widgets.add(
      Row(
        children: [
          Expanded(
            flex: 4,
            child: customContainer(
              size,
              CustomColors.selectedColor7,
              "${CustomUtils.months[now.month - 1]} \nAyı boyunca",
            ),
          ),
          Expanded(
            flex: 3,
            child: customContainer(
              size,
              CustomColors.selectedColor8,
              "En çok satılan ürünler",
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: (size.height / 3),
              color: CustomColors.selectedColor9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#1 ${monthTop3[0]}",
                      style: CustomTextStyles.blackAndBoldTextStyleM,
                    ),
                    Text(
                      "#2 ${monthTop3[1]}",
                      style: CustomTextStyles.blackAndBoldTextStyleM,
                    ),
                    Text(
                      "#3 ${monthTop3[2]}",
                      style: CustomTextStyles.blackAndBoldTextStyleM,
                    ),
                  ],
                ),
              ),
            ),
          ),
          (monthMostProfit.isNotEmpty)
              ? Expanded(
                  flex: 4,
                  child: customContainer(
                    size,
                    CustomColors.selectedColor10,
                    "Bu ayın \nen kârlı ürünü\n${monthMostProfit.keys.first}\n${monthMostProfit[monthMostProfit.keys.first]}₺",
                  ),
                )
              : Container(),
          Expanded(
            flex: 3,
            child: customContainer(
              size,
              CustomColors.selectedColor5,
              "Toplam Gelir\n$monthlyRevenue",
            ),
          ),
          Expanded(
            flex: 3,
            child: customContainer(
              size,
              CustomColors.selectedColor6,
              "Toplam Kâr\n$monthlyProfit",
            ),
          ),
        ],
      ),
    );
  } else {
    widgets.add(Row(
      children: [
        Expanded(
            child: customContainer(size, CustomColors.missingColor,
                "Bu ayın analizleri için yeterli veri bulunmamakta"))
      ],
    ));
  }

  return widgets;
}

// En çok satılan 3 ürünü getirme fonksiyonu
List<String> getTop3Products(Map<String, dynamic> products) {
  var sortedItems = products.entries.toList()
    ..sort((a, b) => b.value['quantity'].compareTo(a.value['quantity']));

  List<String> top3List = [];
  for (var i = 0; i < 3; i++) {
    if (i < sortedItems.length) {
      var item = sortedItems[i];
      String product = "${item.key}: ${item.value["quantity"]}";
      top3List.add(product);
    } else {
      top3List.add("null: 0");
    }
  }

  return top3List;
}

// Karlara göre ürünleri sıralama fonksiyonu
Map<String, double> sortByProfit(Map<String, dynamic> products) {
  Map<String, dynamic> productsMap = products["products"];
  Map<String, double> sortedByProfit = {};
  productsMap.forEach((key, value) {
    if (value is Map && value.containsKey("profit")) {
      sortedByProfit[key] = value["profit"].toDouble();
    }
  });

  sortedByProfit = Map.fromEntries(sortedByProfit.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value)));
  return sortedByProfit;
}

// Özel bir konteyner widget'ı oluşturma fonksiyonu
Container customContainer(Size size, Color color, String text) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: (size.height / 3),
    color: color,
    child: Center(
      child: Text(
        text,
        style: CustomTextStyles.blackAndBoldTextStyleM,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
