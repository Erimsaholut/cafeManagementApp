import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

Text isTableNameNull(String tablename, int tableNum) {
  String tableName = tablename;
  return (tableName == "")
      ? Text(
          "Masa $tableNum",
          style: CustomTextStyles.blackAndBoldTextStyleXl,
        )
      : Text(
          tableName,
          style: CustomTextStyles.blackAndBoldTextStyleXl,
        );
}
