import 'package:flutter/material.dart';

import '../utils/is_table_name_null.dart';
import 'table_screen.dart';

/*Siparişlerin değerleri burada mı tutulacak ayrı dosyadan mı çekilecek ona bak
 sistem oluştuğuda*/
//todo yazı stillerini ve constları taşı hep

class CustomTable extends StatefulWidget {
  CustomTable({super.key, required this.tableNum, this.tableName = ""});

  final int tableNum;
  late String tableName;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          border: Border.all(width: 3.0),
          // Set border width as needed
          //borderRadius: BorderRadius.circular(30.0), // Set border radius as needed
          color: Colors.amber),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) =>
                    CustomTableMenu(
                      tableNum: widget.tableNum,
                      tableName: widget.tableName,
                    ),
                transitionsBuilder: (_, anim, __, child) {
                  return ScaleTransition(
                    scale: anim,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          onLongPress: () {
            TextEditingController _tableNameController = TextEditingController();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Table Name"),
                  content: TextField(
                    controller: _tableNameController,
                    decoration:
                    const InputDecoration(hintText: "Enter table name"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.tableName = "";
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Delete"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.tableName = _tableNameController.text;
                          print("Entered Table Name: ${widget.tableName}");

                          Navigator.pop(context);
                        });
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child:isTableNameNull(widget.tableName,widget.tableNum),
      ),
    );
  }
}
