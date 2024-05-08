import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import '../datas/analyses_data/read_data_analyses.dart';
import '../utils/analysesWidgets/custom_pie_graph.dart';
import '../constants/custom_colors.dart';
import 'package:flutter/material.dart';

class SaleQuantityGraph extends StatefulWidget {
  const SaleQuantityGraph({super.key});

  @override
  State<SaleQuantityGraph> createState() => _SaleQuantityGraphState();
}

class _SaleQuantityGraphState extends State<SaleQuantityGraph> {
  DateTime selectedDate = DateTime.utc(2023, 1, 15);
  String monthOrYear = "Month";
  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık",
  ]; //todo sonra bunu constant olarak dışarı al

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Ürün Satış Adetleri"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              monthOrYear = "Month";
                            });
                          },
                          child: Text(
                            "Aylık",
                            style: CustomTextStyles.blackAndBoldTextStyleM,
                          )),
                      const SizedBox(width: 20),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              monthOrYear = "Year";
                            });
                          },
                          child: Text(
                            "Yıllık",
                            style: CustomTextStyles.blackAndBoldTextStyleM,
                          )),
                    ],
                  ),
                  Text(
                    "${selectedDate.year} Yılı ${(monthOrYear == "Month") ? "${months[selectedDate.month - 1]} Ayı " : ""}Grafiği",
                    style: CustomTextStyles.blackAndBoldTextStyleM,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (monthOrYear == "Month") {
                              if (selectedDate.month == 1) {
                                selectedDate = DateTime(selectedDate.year - 1,
                                    12, selectedDate.day);
                              } else {
                                selectedDate = DateTime(selectedDate.year,
                                    selectedDate.month - 1, selectedDate.day);
                              }
                            } else {
                              selectedDate = DateTime(selectedDate.year - 1,
                                  selectedDate.month, selectedDate.day);
                            }
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_left),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Önceki\n$monthOrYear",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Sonraki\n$monthOrYear",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (monthOrYear == "Month") {
                              if (selectedDate.month == 12) {
                                selectedDate = DateTime(
                                    selectedDate.year + 1, 1, selectedDate.day);
                              } else {
                                selectedDate = DateTime(selectedDate.year,
                                    selectedDate.month + 1, selectedDate.day);
                              }
                            } else {
                              selectedDate = DateTime(selectedDate.year + 1,
                                  selectedDate.month, selectedDate.day);
                            }
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 11,
            child: Row(
              children: [
                //CustomPieChart(itemList: {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//todo flex yerine ekran boyutu yüzdelerini kullan
Future<Map<int, Map<String, int>>?> fetchMonthlyItemCounts(DateTime selectedDate) async {
  AnalysesReader analysesReader = AnalysesReader();

  Map<int, Map<String, int>>? monthlySales =
  await analysesReader.getWeeklyProductSalesForMonth(selectedDate.month, selectedDate.year);
  print("revenueValues:$monthlySales");

  return monthlySales;
}