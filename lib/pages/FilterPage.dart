// ignore_for_file: file_names

import 'package:boss/providers/FilterDateProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/charts/MyFilterWidget.dart';
import 'package:boss/widgets/main/MyAppBarWidget.dart';
import 'package:boss/widgets/MyButtonWidget.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  //DateTime dateTime = DateTime(2016, 8, 3, 17, 45);
  late DateTime _initDate;
  late DateTime _endDate;
  late int _filterState;

  @override
  void initState() {
    super.initState();
    _initDate =
        Provider.of<DateTimeProvider>(context, listen: false).dateTimeInit;
    _endDate =
        Provider.of<DateTimeProvider>(context, listen: false).dateTimeFin;
    _filterState =
        Provider.of<DateTimeProvider>(context, listen: false).filterState;
  }

  void _showDialog({required Widget child, required DateTimeProvider read}) {
    read.filterStateChange(4);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTimeProvider watch = context.watch<DateTimeProvider>();
    DateTimeProvider read = context.read<DateTimeProvider>();

    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    void onPressedCancel() => {
          read.dateTimeFinChange(_endDate),
          read.dateTimeInitChange(_initDate),
          read.filterStateChange(_filterState),
          Navigator.pop(context)
        };
    void onPressedConfirm() => Navigator.pop(context);
    return Scaffold(
      appBar: const MyAppBarWidget(
        title: "Filtro",
        subTitle: "Descripción",
        leading: Icon(Icons.filter_alt_rounded),
        filter: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppDimensions.spacingSmall,
          ),
          MyCardWidget(
            header: false,
            title: "Filtro",
            description: "",
            footer: false,
            widgetContend: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: AppDimensions.spacingSmall),
                myFilterControl(
                    watchTheme: watchTheme, read: read, watch: watch),
                const SizedBox(height: AppDimensions.spacingMedium),
                DateFilterInit(
                    readDateTime: read,
                    datetimeInit: watch.dateTimeInit,
                    datetimeEnd: watch.dateTimeInit,
                    datetimechange: read.dateTimeInitChange,
                    watchTheme: watchTheme),
                const SizedBox(height: AppDimensions.spacingSmall),
                DateFilterEnd(
                    readDateTime: read,
                    datetimeInit: watch.dateTimeInit,
                    datetimeEnd: watch.dateTimeFin,
                    datetimechange: read.dateTimeFinChange,
                    watchTheme: watchTheme),
                const SizedBox(height: AppDimensions.spacingMedium),
                const Row(
                  children: [],
                ),
                Row(
                  children: [
                    MyButtonWidget(
                      text: "Cancelar",
                      onPressed: onPressedCancel,
                      color: watchTheme.colors.lightBackground,
                    ),
                    const SizedBox(
                      width: AppDimensions.spacingSmall,
                    ),
                    MyButtonWidget(
                      text: "Filtrar",
                      onPressed: onPressedConfirm,
                      color: watchTheme.colors.active,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//context.watch<DateTimeProvider>().dateTimeInit
  // ignore: non_constant_identifier_names
  Widget DateFilterInit({
    required DateTime datetimeInit,
    required DateTime datetimeEnd,
    required Function datetimechange,
    required ThemeProvider watchTheme,
    required DateTimeProvider readDateTime,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fecha de inicio",
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            CupertinoButton(
              borderRadius: BorderRadius.zero,
              minSize: AppDimensions.fontSizeSmall,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              child: Text(
                '${datetimeInit.day.toString().padLeft(2, '0')}/${datetimeInit.month.toString().padLeft(2, '0')}/${datetimeInit.year}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                read: readDateTime,
                child: CupertinoDatePicker(
                  initialDateTime: datetimeInit,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    if (newDate.isBefore(datetimeEnd)) {
                      datetimechange(newDate);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Hora de inicio",
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            CupertinoButton(
              borderRadius: BorderRadius.zero,
              minSize: AppDimensions.fontSizeSmall,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              child: Text(
                '${datetimeInit.hour.toString().padLeft(2, '0')}:${datetimeInit.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                read: readDateTime,
                child: CupertinoDatePicker(
                  initialDateTime: datetimeInit,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  // This is called when the user changes the time.
                  onDateTimeChanged: (DateTime newTime) {
                    if (newTime.isBefore(datetimeEnd)) {
                      datetimechange(newTime);
                    } else {
                      datetimechange(datetimeInit);
                    }
                  },
                ),
              ),
              // In this example, the time value is formatted manually.
              // You can use the intl package to format the value based on
              // the user's locale settings.
            ),
          ],
        ),
      ],
    );
  }

  Widget DateFilterEnd({
    required DateTime datetimeInit,
    required DateTime datetimeEnd,
    required Function datetimechange,
    required ThemeProvider watchTheme,
    required DateTimeProvider readDateTime,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fecha de fin",
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            CupertinoButton(
              borderRadius: BorderRadius.zero,
              minSize: AppDimensions.fontSizeSmall,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              child: Text(
                '${datetimeEnd.day.toString().padLeft(2, '0')}/${datetimeEnd.month.toString().padLeft(2, '0')}/${datetimeEnd.year}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                read: readDateTime,
                child: CupertinoDatePicker(
                  initialDateTime: datetimeEnd,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    if (newDate.isAfter(datetimeInit)) {
                      datetimechange(newDate);
                    } else {
                      datetimechange(datetimeEnd);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Hora de fin",
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            CupertinoButton(
              borderRadius: BorderRadius.zero,
              minSize: AppDimensions.fontSizeSmall,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              child: Text(
                '${datetimeEnd.hour.toString().padLeft(2, '0')}:${datetimeEnd.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                read: readDateTime,
                child: CupertinoDatePicker(
                  initialDateTime: datetimeEnd,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  // This is called when the user changes the time.
                  onDateTimeChanged: (DateTime newTime) {
                    if (newTime.isAfter(datetimeInit)) {
                      datetimechange(newTime);
                    }
                  },
                ),
              ),
              // In this example, the time value is formatted manually.
              // You can use the intl package to format the value based on
              // the user's locale settings.
            ),
          ],
        ),
      ],
    );
  }
}
