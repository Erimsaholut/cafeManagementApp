import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';

class ResetAllTableJsonData {

  void resetAllTableJsonFiles() {
    WriteTableData writeTableData = WriteTableData();
    writeTableData.resetAllData();
  }

}

class ResetTableDatas {
  Map<String, dynamic> jsonRawDataFirst = {
    "tables": [],
  };

  void createTables(int numberOfTables) {
    List<Map<String, dynamic>> tables = [];
    for (int i = 1; i <= numberOfTables; i++) {
      Map<String, dynamic> table = {
        "tableNum": i,
        "totalPrice": 0.0,
        "orders": [],
      };
      tables.add(table);
    }
    jsonRawDataFirst['tables'] = tables;
  }
}


