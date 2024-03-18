import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';

class ResetAllAnalysesJsonData {
  AnalysesReader analysesReader = AnalysesReader();

  Future<void> resetAllTableJsonFiles() async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('{"sales": {}}');
  }

  Future<void> loadExampleJsonData() async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('''
    {
  "sales": {
    "1.3.2024": {
      "products": {
        "Çay": {"quantity": 5, "revenue": 25.0},
        "Su": {"quantity": 3, "revenue": 15.0},
        "Nescafe": {"quantity": 2, "revenue": 20.0}
      }
    },
    "2.3.2024": {
      "products": {
        "Türk Kahvesi": {"quantity": 4, "revenue": 80.0},
        "Kokoreç": {"quantity": 2, "revenue": 111.0},
        "Limonata": {"quantity": 3, "revenue": 45.0}
      }
    },
    "3.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0},
        "Ayran": {"quantity": 4, "revenue": 40.0},
        "Kefir": {"quantity": 2, "revenue": 40.0}
      }
    },
    "4.3.2024": {
      "products": {
        "Çay": {"quantity": 6, "revenue": 30.0},
        "Su": {"quantity": 2, "revenue": 10.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0}
      }
    },
    "5.3.2024": {
      "products": {
        "Nescafe": {"quantity": 5, "revenue": 50.0},
        "Limonata": {"quantity": 4, "revenue": 60.0},
        "Ayran": {"quantity": 3, "revenue": 30.0}
      }
    },
    "6.3.2024": {
      "products": {
        "Kokoreç": {"quantity": 3, "revenue": 166.5},
        "Türk Kahvesi": {"quantity": 2, "revenue": 40.0},
        "Ekmek": {"quantity": 6, "revenue": 42.0}
      }
    },
    "7.3.2024": {
      "products": {
        "Çay": {"quantity": 7, "revenue": 35.0},
        "Su": {"quantity": 4, "revenue": 20.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0}
      }
    },
    "8.3.2024": {
      "products": {
        "Çay": {"quantity": 6, "revenue": 30.0},
        "Su": {"quantity": 3, "revenue": 15.0},
        "Nescafe": {"quantity": 2, "revenue": 20.0}
      }
    },
    "9.3.2024": {
      "products": {
        "Türk Kahvesi": {"quantity": 4, "revenue": 80.0},
        "Kokoreç": {"quantity": 2, "revenue": 111.0},
        "Limonata": {"quantity": 3, "revenue": 45.0}
      }
    },
    "10.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0},
        "Ayran": {"quantity": 4, "revenue": 40.0},
        "Kefir": {"quantity": 2, "revenue": 40.0}
      }
    },
    "11.3.2024": {
      "products": {
        "Çay": {"quantity": 6, "revenue": 30.0},
        "Su": {"quantity": 2, "revenue": 10.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0}
      }
    },
    "12.3.2024": {
      "products": {
        "Nescafe": {"quantity": 5, "revenue": 50.0},
        "Limonata": {"quantity": 4, "revenue": 60.0},
        "Ayran": {"quantity": 3, "revenue": 30.0}
      }
    },
    "13.3.2024": {
      "products": {
        "Kokoreç": {"quantity": 3, "revenue": 166.5},
        "Türk Kahvesi": {"quantity": 2, "revenue": 40.0},
        "Ekmek": {"quantity": 6, "revenue": 42.0}
      }
    },
    "14.3.2024": {
      "products": {
        "Çay": {"quantity": 7, "revenue": 35.0},
        "Su": {"quantity": 4, "revenue": 20.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0}
      }
    },
        "15.3.2024": {
      "products": {
        "Çay": {"quantity": 8, "revenue": 40.0},
        "Su": {"quantity": 3, "revenue": 15.0},
        "Nescafe": {"quantity": 2, "revenue": 20.0},
        "Limonata": {"quantity": 5, "revenue": 75.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Türk Kahvesi": {"quantity": 4, "revenue": 80.0}
      }
    },
    "16.3.2024": {
      "products": {
        "Kokoreç": {"quantity": 4, "revenue": 222.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0},
        "Ekmek": {"quantity": 5, "revenue": 35.0}
      }
    },
    "17.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0},
        "Ayran": {"quantity": 4, "revenue": 40.0},
        "Kefir": {"quantity": 2, "revenue": 40.0},
        "Çay": {"quantity": 6, "revenue": 30.0},
        "Su": {"quantity": 2, "revenue": 10.0}
      }
    },
    "18.3.2024": {
      "products": {
        "Türk Kahvesi": {"quantity": 3, "revenue": 60.0},
        "Nescafe": {"quantity": 5, "revenue": 50.0},
        "Kokoreç": {"quantity": 3, "revenue": 166.5},
        "Ekmek": {"quantity": 6, "revenue": 42.0}
      }
    },
    "19.3.2024": {
      "products": {
        "Limonata": {"quantity": 4, "revenue": 60.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0},
        "Çay": {"quantity": 7, "revenue": 35.0},
        "Su": {"quantity": 4, "revenue": 20.0}
      }
    },
    "20.3.2024": {
      "products": {
        "Kefir": {"quantity": 3, "revenue": 60.0},
        "Nescafe": {"quantity": 4, "revenue": 40.0},
        "Kokoreç": {"quantity": 2, "revenue": 111.0},
        "Ekmek": {"quantity": 5, "revenue": 35.0}
      }
    },
    "21.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 2, "revenue": 90.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Türk Kahvesi": {"quantity": 2, "revenue": 40.0},
        "Limonata": {"quantity": 3, "revenue": 45.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0}
      }
    },
    "22.3.2024": {
      "products": {
        "Çay": {"quantity": 8, "revenue": 40.0},
        "Su": {"quantity": 3, "revenue": 15.0},
        "Nescafe": {"quantity": 2, "revenue": 20.0},
        "Limonata": {"quantity": 5, "revenue": 75.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Türk Kahvesi": {"quantity": 4, "revenue": 80.0}
      }
    },
    "23.3.2024": {
      "products": {
        "Kokoreç": {"quantity": 4, "revenue": 222.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0},
        "Ekmek": {"quantity": 5, "revenue": 35.0}
      }
    },
    "24.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0},
        "Ayran": {"quantity": 4, "revenue": 40.0},
        "Kefir": {"quantity": 2, "revenue": 40.0},
        "Çay": {"quantity": 6, "revenue": 30.0},
        "Su": {"quantity": 2, "revenue": 10.0}
      }
    },
    "25.3.2024": {
      "products": {
        "Türk Kahvesi": {"quantity": 3, "revenue": 60.0},
        "Nescafe": {"quantity": 5, "revenue": 50.0},
        "Kokoreç": {"quantity": 3, "revenue": 166.5},
        "Ekmek": {"quantity": 6, "revenue": 42.0}
      }
    },
    "26.3.2024": {
      "products": {
        "Limonata": {"quantity": 4, "revenue": 60.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0},
        "Çay": {"quantity": 7, "revenue": 35.0},
        "Su": {"quantity": 4, "revenue": 20.0}
      }
    },
    "27.3.2024": {
      "products": {
        "Kefir": {"quantity": 3, "revenue": 60.0},
        "Nescafe": {"quantity": 4, "revenue": 40.0},
        "Kokoreç": {"quantity": 2, "revenue": 111.0},
        "Ekmek": {"quantity": 5, "revenue": 35.0}
      }
    },
    "28.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 2, "revenue": 90.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Türk Kahvesi": {"quantity": 2, "revenue": 40.0},
        "Limonata": {"quantity": 3, "revenue": 45.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0}
      }
    },
    "29.3.2024": {
      "products": {
        "Çay": {"quantity": 8, "revenue": 40.0},
        "Su": {"quantity": 3, "revenue": 15.0},
        "Nescafe": {"quantity": 2, "revenue": 20.0},
        "Limonata": {"quantity": 5, "revenue": 75.0},
        "Ayran": {"quantity": 3, "revenue": 30.0},
        "Türk Kahvesi": {"quantity": 4, "revenue": 80.0}
      }
    },
    "30.3.2024": {
      "products": {
        "Kokoreç": {"quantity": 4, "revenue": 222.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0},
        "Ekmek": {"quantity": 5, "revenue": 35.0}
      }
    },
    "31.3.2024": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0},
        "Ayran": {"quantity": 4, "revenue": 40.0},
        "Kefir": {"quantity": 2, "revenue": 40.0},
        "Çay": {"quantity": 6, "revenue": 30.0},
        "Su": {"quantity": 2, "revenue": 10.0}
      }
    }    
  }
}
    ''');
  }
}
