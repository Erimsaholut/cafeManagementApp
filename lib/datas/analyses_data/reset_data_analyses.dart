import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';

class ResetAllAnalysesJsonData {
  AnalysesReader analysesReader = AnalysesReader();

  Future<void> resetAllTableJsonFiles(int code) async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('{"sales": {}}', code);
  }

  Future<void> loadExampleJsonData(int code) async {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;
    if (code == 0) {
      loadExampleDayJsonData(month, year);
    } else if (code == 1) {
      loadExampleMonthJsonData(month, year);
    } else if (code == 2) {
      loadExampleYearJsonData(year);
    } else {
      print("Hatalı Kod girdiniz");
    }
  }

  Future<void> loadExampleDayJsonData(int month, int year) async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('''
    {
  "sales": {
    "1.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 5,
          "revenue": 25.0,
          "profit": 12.5
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0,
          "profit": 7.50
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        }
      }
    },
    "2.$month.$year": {
      "products": {
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        },
        "Kokoreç": {
          "quantity": 2,
          "revenue": 111.0
        },
        "Limonata": {
          "quantity": 3,
          "revenue": 45.0
        }
      }
    },
    "3.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        }
      }
    },
    "4.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 2,
          "revenue": 10.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        }
      }
    },
    "5.$month.$year": {
      "products": {
        "Nescafe": {
          "quantity": 5,
          "revenue": 50.0
        },
        "Limonata": {
          "quantity": 4,
          "revenue": 60.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "6.$month.$year": {
      "products": {
        "Kokoreç": {
          "quantity": 3,
          "revenue": 166.5
        },
        "Türk Kahvesi": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Ekmek": {
          "quantity": 6,
          "revenue": 42.0
        }
      }
    },
    "7.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 7,
          "revenue": 35.0
        },
        "Su": {
          "quantity": 4,
          "revenue": 20.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "8.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        }
      }
    },
    "9.$month.$year": {
      "products": {
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        },
        "Kokoreç": {
          "quantity": 2,
          "revenue": 111.0
        },
        "Limonata": {
          "quantity": 3,
          "revenue": 45.0
        }
      }
    },
    "10.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        }
      }
    },
    "11.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 2,
          "revenue": 10.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        }
      }
    },
    "12.$month.$year": {
      "products": {
        "Nescafe": {
          "quantity": 5,
          "revenue": 50.0
        },
        "Limonata": {
          "quantity": 4,
          "revenue": 60.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "13.$month.$year": {
      "products": {
        "Kokoreç": {
          "quantity": 3,
          "revenue": 166.5
        },
        "Türk Kahvesi": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Ekmek": {
          "quantity": 6,
          "revenue": 42.0
        }
      }
    },
    "14.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 7,
          "revenue": 35.0
        },
        "Su": {
          "quantity": 4,
          "revenue": 20.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "15.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 8,
          "revenue": 40.0
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        },
        "Limonata": {
          "quantity": 5,
          "revenue": 75.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        }
      }
    },
    "17.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 2,
          "revenue": 10.0
        }
      }
    },
    "18.$month.$year": {
      "products": {
        "Türk Kahvesi": {
          "quantity": 3,
          "revenue": 60.0
        },
        "Nescafe": {
          "quantity": 5,
          "revenue": 50.0
        },
        "Kokoreç": {
          "quantity": 3,
          "revenue": 166.5
        },
        "Ekmek": {
          "quantity": 6,
          "revenue": 42.0
        }
      }
    },
    "19.$month.$year": {
      "products": {
        "Limonata": {
          "quantity": 4,
          "revenue": 60.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        },
        "Çay": {
          "quantity": 7,
          "revenue": 35.0
        },
        "Su": {
          "quantity": 4,
          "revenue": 20.0
        }
      }
    },
    "20.$month.$year": {
      "products": {
        "Kefir": {
          "quantity": 3,
          "revenue": 60.0
        },
        "Nescafe": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kokoreç": {
          "quantity": 2,
          "revenue": 111.0
        },
        "Ekmek": {
          "quantity": 5,
          "revenue": 35.0
        }
      }
    },
    "21.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 2,
          "revenue": 90.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Türk Kahvesi": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Limonata": {
          "quantity": 3,
          "revenue": 45.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "22.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 8,
          "revenue": 40.0
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        },
        "Limonata": {
          "quantity": 5,
          "revenue": 75.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        }
      }
    },
    "23.$month.$year": {
      "products": {
        "Kokoreç": {
          "quantity": 4,
          "revenue": 222.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Ekmek": {
          "quantity": 5,
          "revenue": 35.0
        }
      }
    },
    "24.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 2,
          "revenue": 10.0
        }
      }
    },
    "25.$month.$year": {
      "products": {
        "Türk Kahvesi": {
          "quantity": 3,
          "revenue": 60.0
        },
        "Nescafe": {
          "quantity": 5,
          "revenue": 50.0
        },
        "Kokoreç": {
          "quantity": 3,
          "revenue": 166.5
        },
        "Ekmek": {
          "quantity": 6,
          "revenue": 42.0
        }
      }
    },
    "26.$month.$year": {
      "products": {
        "Limonata": {
          "quantity": 4,
          "revenue": 60.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        },
        "Çay": {
          "quantity": 7,
          "revenue": 35.0
        },
        "Su": {
          "quantity": 4,
          "revenue": 20.0
        }
      }
    },
    "27.$month.$year": {
      "products": {
        "Kefir": {
          "quantity": 3,
          "revenue": 60.0
        },
        "Nescafe": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kokoreç": {
          "quantity": 2,
          "revenue": 111.0
        },
        "Ekmek": {
          "quantity": 5,
          "revenue": 35.0
        }
      }
    },
    "28.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 2,
          "revenue": 90.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Türk Kahvesi": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Limonata": {
          "quantity": 3,
          "revenue": 45.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "29.$month.$year": {
      "products": {
        "Çay": {
          "quantity": 8,
          "revenue": 40.0
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        },
        "Limonata": {
          "quantity": 5,
          "revenue": 75.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        }
      }
    },
    "30.$month.$year": {
      "products": {
        "Kokoreç": {
          "quantity": 4,
          "revenue": 222.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        },
        "Ekmek": {
          "quantity": 5,
          "revenue": 35.0
        }
      }
    },
    "31.$month.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 2,
          "revenue": 10.0
        }
      }
    },
        "1.${month + 1}.$year": {
      "products": {
        "Çay": {
          "quantity": 5,
          "revenue": 25.0
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        }
      }
    },
    "2.${month + 1}.$year": {
      "products": {
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        },
        "Kokoreç": {
          "quantity": 2,
          "revenue": 111.0
        },
        "Limonata": {
          "quantity": 3,
          "revenue": 45.0
        }
      }
    },
    "3.${month + 1}.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        }
      }
    },
    "4.${month + 1}.$year": {
      "products": {
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 2,
          "revenue": 10.0
        },
        "Tavuk Döner": {
          "quantity": 2,
          "revenue": 60.0
        }
      }
    },
    "5.${month + 1}.$year": {
      "products": {
        "Nescafe": {
          "quantity": 5,
          "revenue": 50.0
        },
        "Limonata": {
          "quantity": 4,
          "revenue": 60.0
        },
        "Ayran": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "6.${month + 1}.$year": {
      "products": {
        "Kokoreç": {
          "quantity": 3,
          "revenue": 166.5
        },
        "Türk Kahvesi": {
          "quantity": 2,
          "revenue": 40.0
        },
        "Ekmek": {
          "quantity": 6,
          "revenue": 42.0
        }
      }
    },
    "7.${month + 1}.$year": {
      "products": {
        "Çay": {
          "quantity": 7,
          "revenue": 35.0
        },
        "Su": {
          "quantity": 4,
          "revenue": 20.0
        },
        "Nescafe": {
          "quantity": 3,
          "revenue": 30.0
        }
      }
    },
    "8.${month + 1}.$year": {
      "products": {
        "Çay": {
          "quantity": 6,
          "revenue": 30.0
        },
        "Su": {
          "quantity": 3,
          "revenue": 15.0
        },
        "Nescafe": {
          "quantity": 2,
          "revenue": 20.0
        }
      }
    },
    "9.${month + 1}.$year": {
      "products": {
        "Türk Kahvesi": {
          "quantity": 4,
          "revenue": 80.0
        },
        "Kokoreç": {
          "quantity": 2,
          "revenue": 111.0
        },
        "Limonata": {
          "quantity": 3,
          "revenue": 45.0
        }
      }
    },
    "10.${month + 1}.$year": {
      "products": {
        "Sucuklu Tost": {
          "quantity": 3,
          "revenue": 135.0
        },
        "Ayran": {
          "quantity": 4,
          "revenue": 40.0
        },
        "Kefir": {
          "quantity": 2,
          "revenue": 40.0
        }
      }
    }
  }
}
    ''', 0);
  }


  Future<void> loadExampleMonthJsonData(int month, int year) async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('''
    {
  "sales": {
    "1.$year": {
      "products": {
        "Çay": {"quantity": 5, "revenue": 25.0,"profit": 12.5},
        "Su": {"quantity": 3, "revenue": 15.0, "profit": 7.5},
        "Nescafe": {"quantity": 2, "revenue": 20.0, "profit": 10.0}
      }
    },
    "3.$year": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0, "profit": 67.5},
        "Ayran": {"quantity": 4, "revenue": 40.0, "profit": 20.0},
        "Kefir": {"quantity": 2, "revenue": 40.0, "profit": 20.0}
      }
    },
    "4.$year": {
      "products": {
        "Çay": {"quantity": 6, "revenue": 30.0, "profit": 15.0},
        "Su": {"quantity": 2, "revenue": 10.0, "profit": 5.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0, "profit": 30.0}
      }
    },
    "5.$year": {
      "products": {
        "Nescafe": {"quantity": 5, "revenue": 50.0, "profit": 25.0},
        "Limonata": {"quantity": 4, "revenue": 60.0, "profit": 30.0},
        "Ayran": {"quantity": 3, "revenue": 30.0, "profit": 15.0},
        "Çay": {"quantity": 6, "revenue": 30.0, "profit": 15.0},
        "Su": {"quantity": 2, "revenue": 10.0, "profit": 5.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0, "profit": 30.0},
        "Kefir": {"quantity": 7, "revenue": 40.0, "profit": 20.0}
      }
    },
    "6.$year": {
      "products": {
        "Kokoreç": {"quantity": 3, "revenue": 166.5, "profit": 83.25},
        "Türk Kahvesi": {"quantity": 2, "revenue": 40.0, "profit": 20.0},
        "Ekmek": {"quantity": 6, "revenue": 42.0, "profit": 21.0},
        "Çay": {"quantity": 7, "revenue": 35.0, "profit": 17.5},
        "Su": {"quantity": 4, "revenue": 20.0, "profit": 10.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0, "profit": 15.0},
        "Kefir": {"quantity": 1, "revenue": 40.0, "profit": 20.0}
      }
    },
    "7.$year": {
      "products": {
        "Çay": {"quantity": 7, "revenue": 35.0, "profit": 17.5},
        "Su": {"quantity": 4, "revenue": 20.0, "profit": 10.0},
        "Nescafe": {"quantity": 3, "revenue": 30.0, "profit": 15.0},
        "Kefir": {"quantity": 1, "revenue": 40.0, "profit": 20.0},
        "Türk Kahvesi": {"quantity": 5, "revenue": 40.0, "profit": 20.0}
      }
    },
    "8.$year": {
      "products": {
        "Çay": {"quantity": 6, "revenue": 30.0, "profit": 15.0},
        "Su": {"quantity": 3, "revenue": 15.0, "profit": 7.5},
        "Nescafe": {"quantity": 2, "revenue": 20.0, "profit": 10.0}
      }
    },
    "10.$year": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0, "profit": 67.5},
        "Ayran": {"quantity": 4, "revenue": 40.0, "profit": 20.0},
        "Kefir": {"quantity": 2, "revenue": 40.0, "profit": 20.0}
      }
    },
    "11.$year": {
      "products": {
        "Çay": {"quantity": 6, "revenue": 30.0, "profit": 15.0},
        "Su": {"quantity": 2, "revenue": 10.0, "profit": 5.0},
        "Tavuk Döner": {"quantity": 2, "revenue": 60.0, "profit": 30.0}
      }
    },
    "12.$year": {
      "products": {
        "Nescafe": {"quantity": 5, "revenue": 50.0, "profit": 25.0},
        "Limonata": {"quantity": 4, "revenue": 60.0, "profit": 30.0},
        "Ayran": {"quantity": 3, "revenue": 30.0, "profit": 15.0}
      }
    }  
  }
}
    ''', 1);
  }

  Future<void> loadExampleYearJsonData(int year) async {
    AnalysesReader analysesReader = AnalysesReader();
    await analysesReader.writeJsonData('''
{
  "sales": {
    "${year - 2}": {
      "products": {
        "Çay": {"quantity": 5, "revenue": 25.0, "profit": 12.5},
        "Su": {"quantity": 3, "revenue": 15.0, "profit": 7.5},
        "Nescafe": {"quantity": 2, "revenue": 20.0, "profit": 10.0}
      }
    },
    "${year - 1}": {
      "products": {
        "Türk Kahvesi": {"quantity": 4, "revenue": 80.0, "profit": 40.0},
        "Kokoreç": {"quantity": 2, "revenue": 111.0, "profit": 55.5},
        "Limonata": {"quantity": 3, "revenue": 45.0, "profit": 22.5}
      }
    },
    "$year": {
      "products": {
        "Sucuklu Tost": {"quantity": 3, "revenue": 135.0, "profit": 67.5},
        "Ayran": {"quantity": 4, "revenue": 40.0, "profit": 20.0},
        "Kefir": {"quantity": 2, "revenue": 40.0, "profit": 20.0}
      }
    }
  }
}
    ''', 2);
  }
}
