import 'package:cafe_management_system_for_camalti_kahvesi/analysesTest/product_sale_quantity_graph.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/analysesTest/gross_income_graph.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/analysesTest/net_income_graph.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';

import 'text_analyses.dart';

class AnalysesPage extends StatefulWidget {
  const AnalysesPage({super.key});

  @override
  State<AnalysesPage> createState() => _AnalysesPageState();
}

class _AnalysesPageState extends State<AnalysesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Analyses"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Container(
        color: CustomColors.backGroundColor,
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  CustomMenuButton("Satış Adet Grafiği", context: context,
                      onPressedFunction: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const SaleQuantityGraph(),
                        transitionsBuilder: (_, anim, __, child) {
                          return ScaleTransition(
                            scale: anim,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }
                  ),
                  CustomMenuButton(
                    "Brüt Gelir Grafiği",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => const GrossIncomeGraph(),
                          transitionsBuilder: (_, anim, __, child) {
                            return ScaleTransition(
                              scale: anim,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    context: context,
                  ),
                  CustomMenuButton(
                    "Net Kâr Grafiği",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => const NetIncomeGraph(),
                          transitionsBuilder: (_, anim, __, child) {
                            return ScaleTransition(
                              scale: anim,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    context: context,
                  ),
                  CustomMenuButton(
                    "Yazısal Veriler",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => const AnalysesAsAText(),
                          transitionsBuilder: (_, anim, __, child) {
                            return ScaleTransition(
                              scale: anim,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    context: context,
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//todo flex yerine ekran boyutu yüzdelerini kullan grafik alt sayfalarında