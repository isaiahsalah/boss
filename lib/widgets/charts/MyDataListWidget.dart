// ignore_for_file: file_names

import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataListWidget extends StatelessWidget {
  const MyDataListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return MyCardWidget(
      header: false,
      title: "My Bar Chart",
      description: "My Bar Chart",
      footer: true,
      widgetContend: Column(
        children: [
          myListTile(watchTheme: watchTheme),
          const Divider(),
          myListTile(watchTheme: watchTheme),
          const Divider(),
          myListTile(watchTheme: watchTheme),
        ],
      ),
    );
  }
/*
  double rowSize(double quantity, double maxQuantity, double width) {
    final double newQuantity =
        (width - (AppDimensions.spacingMedium * 4)) / (maxQuantity / quantity);
    return newQuantity;
  }*/

  Widget myListTile({required ThemeProvider watchTheme}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.spacingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "data",
                style: TextStyle(
                    color: watchTheme.colors.white,
                    fontSize: AppDimensions.fontSizeSmall),
              ),
              Text(
                "data",
                style: TextStyle(
                    color: watchTheme.colors.lightPrimary,
                    fontSize: AppDimensions.fontSizeXSmall),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    "5000",
                    style: TextStyle(
                        color: watchTheme.colors.white,
                        fontSize: AppDimensions.fontSizeSmall),
                  ),
                  Text(
                    " bs",
                    style: TextStyle(
                        color: watchTheme.colors.lightPrimary,
                        fontSize: AppDimensions.fontSizeXSmall),
                  ),
                ],
              ),
              Text(
                "12 de julio de 2023",
                style: TextStyle(
                    color: watchTheme.colors.lightPrimary,
                    fontSize: AppDimensions.fontSizeXSmall),
              ),
            ],
          )
        ],
      ),
    );
  }
}
