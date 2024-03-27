import 'package:cafe_management_system_for_camalti_kahvesi/pages/admin_panel_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/analyses_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/settings_page.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_util_pages_button.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/table_button.dart';
import 'datas/menu_data/read_data_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ReadData readNewData = ReadData();
  await readNewData.separateMenuItems();
  await readNewData.readJsonData();
  print("newJsonDataReaded");

  String cafeName = await readNewData.getCafeName();
  int tableCount = await readNewData.getTableCount(); // Masa sayısını al

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
      title: 'Deneme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(
          title: cafeName, tableCount: tableCount), // Yeni eklenen parametre
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final int tableCount; // Yeni eklenen alan

  const MyHomePage({Key? key, required this.title, required this.tableCount})
      : super(key: key);

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
          buttonName: 'Settings', goToPage: SettingsPage()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: (widget.tableCount>100?5:4),
        children: myList,
      ),
    );
  }
}