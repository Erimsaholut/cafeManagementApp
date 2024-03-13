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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analyses"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.orange.shade100,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.amberAccent,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text("Ürün Satışları"),
                          CustomAnalysesButton(firstButtonText: 'Gelir', secondButtonText: 'Adet',),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: PieChart(
                          PieChartData(sections: [
                            PieChartSectionData(value: 10, radius: 75),
                            PieChartSectionData(value: 25, radius: 75),
                            PieChartSectionData(value: 10, radius: 75),
                            PieChartSectionData(value: 10, radius: 75),
                          ]),
                          swapAnimationDuration:
                          const Duration(milliseconds: 150),
                          swapAnimationCurve: Curves.linear,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.orange,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text("Aylık satış Oranları"),
                          CustomAnalysesButton(firstButtonText: 'Aylık', secondButtonText: 'Yıllık',),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Padding(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}