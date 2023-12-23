import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

Text isTableNameNull(String tablename, int tableNum) {
  String tableName = tablename;
  return (tableName == "")
      ? Text(
          "Masa $tableNum",
          style: CustomStyles.boldAndBlack,
        )
      : Text(
          tableName,
          style: CustomStyles.boldAndBlack,
        );
}
