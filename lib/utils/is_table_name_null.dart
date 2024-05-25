import 'package:flutter/material.dart';

import '../constants/styles.dart';

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
