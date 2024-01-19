import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';

class ResetAllJsonData {
  void resetJsonFile() {
    WriteTableData writeTableData = WriteTableData(1);
  }
}

class ResetTableData {
  Map<String, dynamic> jsonRawDataFirst = {
    "tableNum": 0,
    "totalPrice": 0,
    "orders": []
  };
}
