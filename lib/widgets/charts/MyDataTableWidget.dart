import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';

DataColumn titleTable(String title) {
  return DataColumn(
    label: Expanded(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppDimensions.fontSizeXXSmall,
        ),
      ),
    ),
  );
}

DataCell descriptionTable(String text) {
  return DataCell(Text(
    text,
    style: TextStyle(fontSize: AppDimensions.fontSizeXXSmall),
  ));
}
