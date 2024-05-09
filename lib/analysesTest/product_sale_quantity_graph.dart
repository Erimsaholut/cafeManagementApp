import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_utils.dart';
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
  late DateTime selectedDate;
  String monthOrYear = "Month";
  late Map<String, int>? datas;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    datas = null; // Başlangıçta datas null olarak tanımla
    _fetchData(selectedDate);
  }

  Future<void> _fetchData(DateTime date) async {
    Map<String, int> data = await fetchMonthlyItemCounts(date);
    setState(() {
      print(selectedDate);
      datas = data;
    });
  }

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
                        ),
                      ),
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
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${selectedDate.year} Yılı ${(monthOrYear == "Month") ? "${CustomUtils.months[selectedDate.month - 1]} Ayı " : ""}Grafiği",
                    style: CustomTextStyles.blackAndBoldTextStyleM,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          DateTime newDate;
                          if (monthOrYear == "Month") {
                            newDate = (selectedDate.month == 1)
                                ? DateTime(
                                    selectedDate.year - 1, 12, selectedDate.day)
                                : DateTime(selectedDate.year,
                                    selectedDate.month - 1, selectedDate.day);
                          } else {
                            newDate = DateTime(selectedDate.year - 1,
                                selectedDate.month, selectedDate.day);
                          }
                          await _fetchData(newDate);
                          setState(() {
                            selectedDate = newDate;
                            print("Selected Date:");
                            print(selectedDate);
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
                        onPressed: () async {
                          DateTime newDate;
                          if (monthOrYear == "Month") {
                            newDate = (selectedDate.month == 12)
                                ? DateTime(
                                    selectedDate.year + 1, 1, selectedDate.day)
                                : DateTime(selectedDate.year,
                                    selectedDate.month + 1, selectedDate.day);
                          } else {
                            newDate = DateTime(selectedDate.year + 1,
                                selectedDate.month, selectedDate.day);
                          }
                          await _fetchData(newDate);
                          setState(() {
                            selectedDate = newDate;
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
          Expanded(
            flex: 11,
            child: datas != null
                ? Row(
                    children: [
                      CustomPieChart(itemList: datas!),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

Future<Map<String, int>> fetchMonthlyItemCounts(DateTime selectedDate) async {
  AnalysesReader analysesReader = AnalysesReader();

  Map<String, int>? monthlySales = (await analysesReader.testAylikItemAdetleri(
      selectedDate.month, selectedDate.year));
  print("monthlySales:$monthlySales");
  print("yıl:${selectedDate.year} ay:${selectedDate.month}");

  if (monthlySales == null) {
    print("Hata: Veriler getirilemedi. ");
    return {};
  }

  return monthlySales;
}
