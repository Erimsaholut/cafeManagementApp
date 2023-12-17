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
        backgroundColor: Color(0XFFACBCFF),
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
                      padding: EdgeInsets.all(8.0),
                      color: Colors.deepPurple.shade200,
                      child: const SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("6tost"),
                            Text("24 çay"),
                            Text("7 feleğin sillesi"),
                            Text("6tost"),
                            Text("24 çay"),
                            Text("7 feleğin sillesi"),
                            Text("6tost"),
                            Text("24 çay"),
                            Text("7 feleğin sillesi"),
                            Text("6tost"),
                            Text("24 çay"),
                            Text("7 feleğin sillesi"),
                            Text("6tost"),
                            Text("24 çay"),
                            Text("7 feleğin sillesi"),
                            Text("6tost"),
                            Text("24 çay"),
                            Text("7 feleğin sillesi"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.redAccent,
                      child: Text("Toplam Hesap: 973 ₺"),
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
                  TextButton(
                    onPressed: () {},
                    child: Text("Ekle Sipariş"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Azalt Sipariş"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Masa Ödendi"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFAEE2FF),
    );
  }
}
