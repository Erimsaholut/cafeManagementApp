import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:flutter/material.dart';

import '../constants/custom_utils.dart';
import '../constants/styles.dart';
import '../datas/analyses_data/read_data_analyses.dart';
import '../utils/analysesWidgets/custom_line_chart.dart';

class GrossIncomeGraph extends StatefulWidget {
  const GrossIncomeGraph({super.key});

  @override
  State<GrossIncomeGraph> createState() => _GrossIncomeGraphState();
}

class _GrossIncomeGraphState extends State<GrossIncomeGraph> {
  DateTime selectedDate = DateTime.now();
  String monthOrYear = "Month";
  late List<double> datas;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    datas = [];
    _fetchData(selectedDate);
  }

  Future<void> _fetchData(DateTime date) async {
    if(monthOrYear=="Month"){
      List<double> data = await fetchMonthlyProfitValues(date);

      setState(() {
        print(selectedDate);
        datas = data;
      });
    }else{
      List<double> data = await fetchYearlyProfitValues(date);

      setState(() {
        print(selectedDate);
        datas = data;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Brüt Gelir Grafiği"),
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
                            _fetchData(selectedDate);
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
                            _fetchData(selectedDate);
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
            child: datas.isNotEmpty
                ? CustomLineChart(valueList: datas,selectedDate: selectedDate,)
                : const Center(child: CircularProgressIndicator()),
          ),

        ],
      ),
    );
  }
}

Future<List<double>> fetchYearlyProfitValues(DateTime selectedDate) async {
  AnalysesReader analysesReader = AnalysesReader();
  Map<String, double>? monthlySales =
      await analysesReader.getMonthlyTotalRevenueForYear(selectedDate.year);
  List<double> revenueValues = monthlySales.values.toList();
  return revenueValues;
}

Future<List<double>> fetchMonthlyProfitValues(DateTime selectedDate) async {
  AnalysesReader analysesReader = AnalysesReader();
  Map<String, double>? monthlySales =
  await analysesReader.getDailyTotalRevenueForMonth(selectedDate.month,selectedDate.year);
  List<double> revenueValues = monthlySales.values.toList();
  return revenueValues;
}
