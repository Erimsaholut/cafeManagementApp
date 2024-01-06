import 'package:flutter/material.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_new_data.dart';

class AnalyzesPage extends StatelessWidget {
  final ReadNewData readNewData = ReadNewData();

  AnalyzesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analyzes",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              String counter = await readNewData.readCounter();
              print('Counter: $counter');
            },
            child: const Text("Oku Test"),
          ),
        ],
      ),
    );
  }
}
