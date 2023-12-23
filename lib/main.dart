import 'package:flutter/material.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/prepareData.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/settings_button.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/table_button.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized
  PrepareData prepareData = PrepareData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deneme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Çamaltı Kahvehanesi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> mylist =
      List.generate(23, (index) => CustomTable(tableNum: index + 1))
        ..add(SettingsButton());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: mylist,
      ),
    );
  }
}
