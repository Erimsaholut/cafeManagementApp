import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../utils/custom_analyses_button.dart';

class AnalysesPage extends StatefulWidget {
  const AnalysesPage({Key? key}) : super(key: key);

  @override
  State<AnalysesPage> createState() => _AnalysesPageState();
}

class _AnalysesPageState extends State<AnalysesPage> {
  bool isButton1Active = true;
  bool isButton2Active = true;
  AnalysesReader analysesReader  = AnalysesReader();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analyses"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.orange.shade100,
        child: SingleChildScrollView(
          child: [
            Column(
              children: [
                Container(
                  color: Colors.amberAccent,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text("Ürün Satışları"),
                            TextButton(
                                onPressed: () async {
                                  Map<String, dynamic>? analysesRaw = await analysesReader.getRawData();

                                  if (analysesRaw != null) {
                                    var salesData = analysesRaw['sales'];
                                    if (salesData != null) {
                                      salesData.forEach((date, data) {
                                        print("Tarih: $date");
                                        print("Veri: $data");
                                        print("########################");
                                      });
                                    }
                                  }
                                },
                                child: Text("data")
                            ),


                            CustomAnalysesButton(firstButtonText: 'Gelir', secondButtonText: 'Adet',),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text("Aylık satış Oranları"),
                          CustomAnalysesButton(firstButtonText: 'Haftalık', secondButtonText: 'Aylık',thirdButtonText: 'Yıllık'),
                        ],
                      ),
                      /*Padding(
                    padding: const EdgeInsets.all(8),
                    child: LineChart(
                      LineChartData(
                        minX: 100,
                        minY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            color: Colors.blueAccent,
                            barWidth: 6,
                          ),
                          LineChartBarData(
                            color: Colors.blueAccent,
                            barWidth: 6,
                          ),
                          LineChartBarData(
                            color: Colors.blueAccent,
                            barWidth: 6,
                          ),
                        ],
                        titlesData: const FlTitlesData(
                          topTitles: AxisTitles(),
                          rightTitles: AxisTitles(),
                        ),
                      ),
                    ),
                  ),*/
                    ],
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}