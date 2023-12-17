import 'package:cafe_management_system_for_camalti_kahvesi/utils/is_table_name_null.dart';
import 'package:flutter/material.dart';

class CustomTableMenu extends StatelessWidget {
  CustomTableMenu(
      {super.key, required int this.tableNum, required this.tableName});

  final int tableNum;
  final String tableName;

  //bunların final olması sıkıntı çıkarabilir dikkat et
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isTableNameNull(tableName, tableNum),
        backgroundColor: Colors.lime,
      ),
      body: const Column(
        children: [Text("6tost\n24 çay\n7 feleğin sillesi")],
      ),
    );
  }
}
