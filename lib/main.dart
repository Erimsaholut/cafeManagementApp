import 'package:cafe_management_system_for_camalti_kahvesi/setup_screen.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_util_pages_button.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/admin_panel_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/table_button.dart';
import 'datas/menu_data/read_data_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'analyses/analysesTest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ReadMenuData readNewData = ReadMenuData();
  await readNewData.separateMenuItems();
  await readNewData.readJsonData();
  print("newJsonDataReaded");

  String cafeName = await readNewData.getCafeName();
  int tableCount = await readNewData.getTableCount();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(MyApp(cafeName: cafeName, tableCount: tableCount)));
}

class MyApp extends StatelessWidget {
  final String cafeName;
  final int tableCount;

  const MyApp({Key? key, required this.cafeName, required this.tableCount})
      : super(key: key);

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
          buttonName: 'Setup Screen', goToPage: SetupScreen()))
      ..add(const CustomUtilPagesButton(
          buttonName: 'Settings', goToPage: SettingsPage()));

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

//todo en en en son gerekli default verilerin yüklenmesi ve kurulumun yapılması için özel bir ekran çıkacak Kafe ismi ve masa sayısını alacak.
//sadece hard resette ve sıfır açılışta kullanılacak.

//todo text kısmına premium olup olmadığı bilgisini ekle
        //hatta kafe isminin yanına da ekle ezik hissetsin kendini