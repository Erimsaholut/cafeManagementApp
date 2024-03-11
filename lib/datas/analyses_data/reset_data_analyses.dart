import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';

class ResetAllAnalysesJsonData {
  AnalysesReader analysesReader = AnalysesReader();

  Future<void> resetAllTableJsonFiles() async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('{"sales": {}}');
  }
}