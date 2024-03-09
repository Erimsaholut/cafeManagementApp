import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/write_data_analyses.dart';

class ResetAllAnalysesJsonData {

  void resetAllTableJsonFiles() {
    WriteAnalysesData writeAnalysesData = WriteAnalysesData();
  }

}

class ResetAnalysesDatas {
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


