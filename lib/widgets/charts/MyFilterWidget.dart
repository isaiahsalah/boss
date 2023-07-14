// ignore_for_file: file_names

import 'package:boss/providers/FilterDateProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:boss/widgets/components/MySlidingControlWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFilterWidget extends StatefulWidget {
  const MyFilterWidget({super.key});

  @override
  State<MyFilterWidget> createState() => _MyFilterWidgetState();
}

class _MyFilterWidgetState extends State<MyFilterWidget> {
  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    DateTimeProvider watch = context.watch<DateTimeProvider>();
    DateTimeProvider read = context.read<DateTimeProvider>();
    return MyCardWidget(
      header: false,
      title: "title",
      description: "",
      footer: false,
      widgetContend: Column(
        children: [
          myFilterControl(read: read, watch: watch, watchTheme: watchTheme),
        ],
      ),
    );
  }
}

Widget myFilterControl(
    {required read, required watch, required ThemeProvider watchTheme}) {
  return MySlidingControlWidget(
    backColor: watchTheme.colors.lightBackground,
    color: watchTheme.colors.primary,
    initialValue: watch.filterState,
    itemsMenu: const {
      1: Text('Semana'),
      2: Text('Mes'),
      3: Text('Año'),
      4: Text('Custom'),
    },
    onValueChanged: (int i) {
      read.filterStateChange(i);

      final DateTime todayDateTime = DateTime.now();

      switch (i) {
        case 1:
          read.dateTimeInitChange(DateTime(todayDateTime.year,
              todayDateTime.month, todayDateTime.day - 7, 0, 0, 0));
          read.dateTimeFinChange(DateTime(todayDateTime.year,
              todayDateTime.month, todayDateTime.day, 0, 0, 0));
          break;
        case 2:
          read.dateTimeInitChange(DateTime(todayDateTime.year,
              todayDateTime.month - 1, todayDateTime.day, 0, 0, 0));
          read.dateTimeFinChange(DateTime(todayDateTime.year,
              todayDateTime.month, todayDateTime.day, 0, 0, 0));
          break;
        case 3:
          read.dateTimeInitChange(DateTime(todayDateTime.year - 1,
              todayDateTime.month, todayDateTime.day, 0, 0, 0));
          read.dateTimeFinChange(DateTime(todayDateTime.year,
              todayDateTime.month, todayDateTime.day, 0, 0, 0));
          break;
      }
    },
  );
}
