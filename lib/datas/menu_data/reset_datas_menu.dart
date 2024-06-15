import 'package:adisso/datas/menu_data/write_data_menu.dart';

class ResetAllJsonData {
  void resetMenuToDemo() {
    WriteData writeData = WriteData();
    writeData.resetToDemoMenu();
  }
  void resetMenuToBlank() {
    WriteData writeData = WriteData();
    writeData.resetToBlankMenu();
  }
}

class ResetMenuDatas {
  Map<String, dynamic> jsonMenuDemoData = {
    "categories": ["food", "drink", "dessert","services"],
    "menu": [
      {
        "name": "Çay",
        "price": 5.0,
        "profit": 2.5,
        "type": "drink",
        "ingredients": []
      },
      {
        "name": "Su",
        "price": 5.0,
        "profit": 2.5,
        "type": "drink",
        "ingredients": []
      },
      {
        "name": "Ayran",
        "price": 10.0,
        "profit": 5.0,
        "type": "drink",
        "ingredients": []
      },
      {
        "name": "Limonata",
        "price": 15.0,
        "profit": 7.5,
        "type": "drink",
        "ingredients": []
      },
      {
        "name": "Kefir",
        "price": 20.0,
        "profit": 10.0,
        "type": "drink",
        "ingredients": []
      },
      {
        "name": "Nescafe",
        "price": 10.0,
        "profit": 5.0,
        "type": "drink",
        "ingredients": ["Sade", "İkisi bir arada", "Üçü Bir arada"]
      },
      {
        "name": "Türk Kahvesi",
        "price": 20.0,
        "profit": 10.0,
        "type": "drink",
        "ingredients": ["Sade", "Az Şekerli", "Orta Şekerli", "Şekerli"]
      },
      {
        "name": "Oralet",
        "price": 5.0,
        "profit": 2.5,
        "type": "drink",
        "ingredients": ["Portakal", "Limon", "Kivi", "Muz"]
      },
      {
        "name": "Sucuklu Tost",
        "price": 45.0,
        "profit": 22.5,
        "type": "food",
        "ingredients": ["Ketçap", "Mayonez", "Soğan", "Yeşillik", "Turşu"]
      },
      {
        "name": "Tavuk Döner",
        "price": 30.0,
        "profit": 15.0,
        "type": "food",
        "ingredients": ["Ketçap", "Mayonez", "Soğan", "Turşu"]
      },
      {
        "name": "Kokoreç",
        "price": 55.50,
        "profit": 27.75,
        "type": "food",
        "ingredients": ["Acı", "Kimyon", "Kekik"]
      },
      {
        "name": "Ekmek",
        "price": 7.0,
        "profit": 3.5,
        "type": "food",
        "ingredients": []
      },
  {
  "name": "Test dessert",
  "price": 7.0,
  "profit": 3.5,
  "type": "dessert",
  "ingredients": []
}
    ]
  };
}

class RemoveMenuDatas {
  Map<String, dynamic> jsonMenuResetData = {"categories": [], "menu": []};
}
