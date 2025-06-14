import 'package:adisso/datas/menu_data/write_data_menu.dart';

class ResetAllJsonData {
  void resetMenuToDemo() {
    WriteMenuData writeData = WriteMenuData();
    writeData.resetToDemoMenu();
  }
  void resetMenuToBlank() {
    WriteMenuData writeData = WriteMenuData();
    writeData.resetToBlankMenu();
  }
}

class ResetMenuDatas {
  Map<String, dynamic> jsonMenuDemoData = {
    "categories": ["Yiyecek", "İçecek", "Tatlılar","services"],
    "menu": [
      {
        "name": "Çay",
        "price": 5.0,
        "profit": 2.5,
        "type": "İçecek",
        "ingredients": []
      },
      {
        "name": "Su",
        "price": 5.0,
        "profit": 2.5,
        "type": "İçecek",
        "ingredients": []
      },
      {
        "name": "Ayran",
        "price": 10.0,
        "profit": 5.0,
        "type": "İçecek",
        "ingredients": []
      },
      {
        "name": "Limonata",
        "price": 15.0,
        "profit": 7.5,
        "type": "İçecek",
        "ingredients": []
      },
      {
        "name": "Kefir",
        "price": 20.0,
        "profit": 10.0,
        "type": "İçecek",
        "ingredients": []
      },
      {
        "name": "Nescafe",
        "price": 10.0,
        "profit": 5.0,
        "type": "İçecek",
        "ingredients": ["Sade", "İkisi bir arada", "Üçü Bir arada"]
      },
      {
        "name": "Türk Kahvesi",
        "price": 20.0,
        "profit": 10.0,
        "type": "İçecek",
        "ingredients": ["Sade", "Az Şekerli", "Orta Şekerli", "Şekerli"]
      },
      {
        "name": "Oralet",
        "price": 5.0,
        "profit": 2.5,
        "type": "İçecek",
        "ingredients": ["Portakal", "Limon", "Kivi", "Muz"]
      },
      {
        "name": "Sucuklu Tost",
        "price": 45.0,
        "profit": 22.5,
        "type": "Yiyecek",
        "ingredients": ["Ketçap", "Mayonez", "Soğan", "Yeşillik", "Turşu"]
      },
      {
        "name": "Tavuk Döner",
        "price": 30.0,
        "profit": 15.0,
        "type": "Yiyecek",
        "ingredients": ["Ketçap", "Mayonez", "Soğan", "Turşu"]
      },
      {
        "name": "Kokoreç",
        "price": 55.50,
        "profit": 27.75,
        "type": "Yiyecek",
        "ingredients": ["Acı", "Kimyon", "Kekik"]
      },
      {
        "name": "Ekmek",
        "price": 7.0,
        "profit": 3.5,
        "type": "Yiyecek",
        "ingredients": []
      },
  {
  "name": "Test dessert",
  "price": 7.0,
  "profit": 3.5,
  "type": "Tatlılar",
  "ingredients": []
}
    ]
  };
}

class RemoveMenuDatas {
  Map<String, dynamic> jsonMenuResetData = {"categories": [], "menu": []};
}
