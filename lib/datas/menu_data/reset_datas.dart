import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/write_data.dart';

class ResetAllJsonData {
  void resetJsonFile() {
    WriteData writeData = WriteData();
    writeData.resetData();
  }
}

class ResetDatas {
  Map<String, dynamic> jsonDemoRawData = {
    "cafe_name": "Çamaltı Kahvehanesi",
    "table_count": 22,
    "menu": [
      {
        "id": 1,
        "name": "Çay",
        "price": 5.0,
        "type": "drink",
        "ingredients": []
      },
      {"id": 2, "name": "Su", "price": 5.0, "type": "drink", "ingredients": []},
      {
        "id": 3,
        "name": "Ayran",
        "price": 10.0,
        "type": "drink",
        "ingredients": []
      },
      {
        "id": 4,
        "name": "Limonata",
        "price": 15.0,
        "type": "drink",
        "ingredients": []
      },
      {
        "id": 5,
        "name": "Kefir",
        "price": 20.0,
        "type": "drink",
        "ingredients": []
      },
      {
        "id": 6,
        "name": "Nescafe",
        "price": 10.0,
        "type": "drink",
        "ingredients": ["Sade", "İkisi bir arada", "Üçü Bir arada"]
      },
      {
        "id": 7,
        "name": "Türk Kahvesi",
        "price": 20.0,
        "type": "drink",
        "ingredients": ["Sade", "Az Şekerli", "Orta Şekerli", "Şekerli"]
      },
      {
        "id": 8,
        "name": "Oralet",
        "price": 5.0,
        "type": "drink",
        "ingredients": ["Portakal", "Limon", "Kivi", "Muz"]
      },
      {
        "id": 9,
        "name": "Sucuklu Tost",
        "price": 45.0,
        "type": "food",
        "ingredients": ["Ketçap", "Mayonez", "Soğan", "Yeşillik", "Turşu"]
      },
      {
        "id": 10,
        "name": "Tavuk Döner",
        "price": 35.00,
        "type": "food",
        "ingredients": ["Ketçap", "Mayonez", "Soğan", "Turşu"]
      },
      {
        "id": 11,
        "name": "Kokoreç",
        "price": 5.50,
        "type": "food",
        "ingredients": ["Acı", "Kimyon", "Kekik"]
      },
      {
        "id": 12,
        "name": "Ekmek",
        "price": 7.00,
        "type": "food",
        "ingredients": []
      }
    ]
  };
}
