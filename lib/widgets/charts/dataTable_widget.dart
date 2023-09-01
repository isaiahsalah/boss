// ignore_for_file: file_names

import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';

DataColumn titleTable(String title) {
  return DataColumn(
    label: Expanded(
      child: Text(
        title,
        style: const TextStyle(
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
    style: const TextStyle(fontSize: AppDimensions.fontSizeXXSmall),
  ));
}
