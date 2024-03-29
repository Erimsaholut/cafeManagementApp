import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

import 'is_table_name_null.dart';
import '../pages/main_table_screen.dart';

/*Siparişlerin değerleri burada mı tutulacak ayrı dosyadan mı çekilecek ona bak
 sistem oluştuğuda*/


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
          color: CustomColors.buttonColor),
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) =>
                    MainTableScreen(
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
          style: CustomButtonStyles.transparentButtonStyle,
          child:isTableNameNull(widget.tableName,widget.tableNum),
      ),
    );
  }
}
