import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_util_pages_button.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/admin_panel_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/table_button.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/setup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'analyses/analysesTest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences objesini oluşturun
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // isOpenedBefore değerini kontrol edin
  final int? firstOpen = prefs.getInt('isOpenedBefore');

  // isOpenedBefore değeri boş ise SetupScreen sayfasını göster
  if (firstOpen == null) {
    runApp(const SetupApp());
  } else {
    // Değer dolu ise, uygulamayı normal şekilde başlat
    runApp(const NormalApp(cafeName: '', tableCount: 1,));
  }
}


class SetupApp extends StatelessWidget {
  const SetupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SetupScreen(),
    );
  }
}


class NormalApp extends StatelessWidget {
  final String cafeName;
  final int tableCount;

  const NormalApp({super.key, required this.cafeName, required this.tableCount});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(
          title: cafeName, tableCount: tableCount), // Yeni eklenen parametre
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final int tableCount;

  const MyHomePage({super.key, required this.title, required this.tableCount});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> myList;

  @override
  void initState() {
    super.initState();
    myList = List.generate(
        widget.tableCount, (index) => CustomTable(tableNum: index + 1))
      ..add(CustomUtilPagesButton(
          buttonName: "Admin Panel", goToPage: AdminPanel()))
      ..add(const CustomUtilPagesButton(
          buttonName: 'Analyses', goToPage: AnalysesPage()))
      ..add(const CustomUtilPagesButton(
          buttonName: 'Settings', goToPage: SettingsPage()))
      ..add(const CustomUtilPagesButton(
          buttonName: 'Premium Edin !\nDeneme sürümü kalan gün sayısı:', goToPage: SetupScreen()));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.appbarColor,
        title: Text(widget.title,style: TextStyle(color: CustomColors.textColor),),
      ),
      body: GridView.count(
        crossAxisCount: (widget.tableCount>100?5:4),
        children: myList,
      ),
    );
  }
}

//todo text kısmına premium olup olmadığı bilgisini ekle ve kalan ürün
        //hatta kafe isminin yanına da ekle ezik hissetsin kendini

 //todo kalan ürün denetim sistemi