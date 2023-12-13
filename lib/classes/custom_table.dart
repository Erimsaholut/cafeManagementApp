import 'package:flutter/material.dart';

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
          print(widget.tableNum);
          print(widget.tableName);
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
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // Kullanıcının girdiği değeri alabilirsiniz.
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
        child: (widget.tableName == "")
            ? Text(
                "Masa ${widget.tableNum}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24),
              )
            : Text(
                "${widget.tableName}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24),
              ),
      ),
    );
  }
}
