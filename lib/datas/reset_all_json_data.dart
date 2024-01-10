import 'package:cafe_management_system_for_camalti_kahvesi/datas/write_data.dart';

class ResetAllJsonData{
  void resetJsonFile() {
    WriteData writeData = WriteData();
    writeData.resetData();
  }
}