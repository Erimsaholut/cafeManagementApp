import 'package:flutter/material.dart';

class AnalysesPage extends StatelessWidget {
  const AnalysesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analyses"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.orangeAccent,
      ),
    );
  }
}
