import 'package:flutter/material.dart';

Text isTableNameNull(String tablename, int tableNum) {
  String tableName = tablename;
  return (tableName == "")
      ? Text(
          "Masa $tableNum",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
        )
      : Text(
          tableName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
        );
}
