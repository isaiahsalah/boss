// ignore_for_file: file_names

import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/filterDate_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/components/slidingControl_widget.dart';
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
    return CardTemplate(
      filter: Icon(Icons.abc),
      trailing: SizedBox(),
      header: false,
      data: WidgetDataModel(titulo: "", descripcion: "", contenido: []),
      dataDetail: tableModelFuture(),
      footer: false,
      child: Column(
        children: [
          myFilterControl(read: read, watch: watch, watchTheme: watchTheme),
        ],
      ),
    );
  }
}

Future<TableModel> tableModelFuture() async {
  return await TableModel();
}

Widget myFilterControl(
    {required read, required watch, required ThemeProvider watchTheme}) {
  return MySlidingControlWidget(
    backColor: watchTheme.colors.primary,
    color: watchTheme.colors.background,
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
