import 'package:adisso/utils/custom_util_pages_button.dart';
import 'package:adisso/constants/custom_colors.dart';
import 'package:adisso/pages/admin_panel_page.dart';
import 'package:adisso/pages/settings_page.dart';
import 'package:adisso/utils/table_button.dart';
import 'package:adisso/setup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'analyses/analyses_page.dart';
import 'datas/menu_data/reset_datas_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? firstOpen = prefs.getInt('isOpenedBefore');
  final bool? loadExampleMenu = prefs.getBool('loadExampleMenu');

  prefs.setBool('isPremium', false);

  /*
  final int? firstOpen = null;
  prefs.remove("cafeName");
  prefs.remove("tableCount");
*/

  if (loadExampleMenu == false) {
    ResetAllJsonData resetAllJsonData = ResetAllJsonData();
    resetAllJsonData.resetMenuToBlank();
  }

  if (firstOpen == null) {
    runApp(const SetupApp());
  } else {
    await normalRun();
  }
}

Future<void> normalRun() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String cafeName = prefs.getString('cafeName') ?? 'Default Cafe';
  int tableCount = prefs.getInt('tableCount') ?? 10;

  int dDay = prefs.getInt('firstOpenDay') ?? DateTime.now().day;
  int fMonth = prefs.getInt('firstOpenMonth') ?? DateTime.now().month;
  int fYear = prefs.getInt('firstOpenYear') ?? DateTime.now().year;
  DateTime firstOpenDate = DateTime(dDay, fMonth, fYear);

  print(firstOpenDate);

  DateTime currentDate = DateTime.now();
  Duration difference = currentDate.difference(firstOpenDate);
  int dayDifference = 30 - difference.inDays;

  print('Uygulamanın ilk açılışından bu yana geçen gün sayısı: $dayDifference');

  runApp(NormalApp(
    cafeName: cafeName,
    tableCount: tableCount,
    dayDifference: dayDifference,
  ));
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
  final int dayDifference;

  const NormalApp(
      {super.key,
      required this.cafeName,
      required this.tableCount,
      required this.dayDifference});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(
          title: cafeName,
          tableCount: tableCount,
          dayDifference: dayDifference),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final int tableCount;
  final int dayDifference;

  const MyHomePage(
      {super.key,
      required this.title,
      required this.tableCount,
      required this.dayDifference});

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
      ..add(CustomUtilPagesButton(
          buttonName: 'Deneme Hesabı kalan gün: ${widget.dayDifference}',
          goToPage: SizedBox()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.appbarColor,
        title: Text(
          widget.title,
          style: TextStyle(color: CustomColors.textColor),
        ),
      ),
      body: GridView.count(
        crossAxisCount: (widget.tableCount > 100 ? 5 : 4),
        children: myList,
      ),
    );
  }
}

//todo net kar analizi premium özel olacak // ekledik ama kullanmak sana kalmış
//todo log eklenebilir.
//todo kategoriler zaten olmazsa olmaz
