import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/is_table_name_null.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'orders_page.dart';

class CustomTableMenu extends StatelessWidget {
  CustomTableMenu({super.key, required this.tableNum, required this.tableName});

  /* genel bakışların olduğu sayfa*/

  final int tableNum;
  final String tableName;
  final List<String> orders = ["a", "b","c","d"];

  //bunların final olması sıkıntı çıkarabilir dikkat et
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isTableNameNull(tableName, tableNum),
        backgroundColor: CustomColors.appbarBlue,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.lime,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.deepPurple.shade200,
                      child: ListView(
                        children: [
                          ...textWidgetsFromList(orders),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.redAccent,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Toplam Hesap: 973 ₺",
                            style: CustomStyles.blackAndBoldTextStyleL,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.tealAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomMenuButton("Ekle Sipariş", onPressedFunction: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const MenuScreen(),
                        transitionsBuilder: (_, anim, __, child) {
                          return ScaleTransition(
                            scale: anim,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }),
                  CustomMenuButton("Azalt Sipariş", onPressedFunction: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => OrdersPage(
                          initialOrders: orders,
                        ),
                        transitionsBuilder: (_, anim, __, child) {
                          return ScaleTransition(
                            scale: anim,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }),
                  CustomMenuButton(
                    "Masa Ödendi",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFAEE2FF),
    );
  }
}

List<Widget> textWidgetsFromList(List<String> textList) {
  List<Widget> newList = [];
  for (var i in textList) {
    newList.add(
      Text(
        i,
        style: CustomStyles.blackAndBoldTextStyleM,
      ),
    );
  }

  return newList;
}