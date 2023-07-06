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

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
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
    ThemeProvider readTheme = context.read<ThemeProvider>();

    final DateTime dateInit = watch.dateTimeInit.copyWith();
    final DateTime dateEnd = watch.dateTimeFin.copyWith();

    void onPressedCancel() => {
          read.dateTimeFinChange(dateEnd),
          read.dateTimeInitChange(dateInit),
          print(dateInit),
          Navigator.pop(context)
        };
    void onPressedConfirm() => {Navigator.pop(context)};
    return Scaffold(
      appBar: MyAppBarWidget(
        title: "Filtro",
        subTitle: "Descripción",
        leading: Icon(Icons.filter_alt_rounded),
        filter: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppDimensions.spacingSmall,
          ),
          MyCardWidget(
            title: "Filtro",
            description: "",
            footer: false,
            widgetContend: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: AppDimensions.spacingSmall),
                  myFilterControl(read: read, watch: watch),
                  SizedBox(height: AppDimensions.spacingMedium),
                  DateFilter(
                      datetime: watch.dateTimeInit,
                      datetimechange: read.dateTimeInitChange,
                      watchTheme: watchTheme),
                  SizedBox(height: AppDimensions.spacingSmall),
                  DateFilter(
                      datetime: watch.dateTimeFin,
                      datetimechange: read.dateTimeFinChange,
                      watchTheme: watchTheme),
                  SizedBox(height: AppDimensions.spacingMedium),
                  Row(
                    children: [],
                  ),
                  Row(
                    children: [
                      MyButtonWidget(
                        text: "Cancelar",
                        onPressed: onPressedCancel,
                        color: watchTheme.colors.lightBackground,
                      ),
                      SizedBox(
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
          ),
        ],
      ),
    );
    ;
  }

//context.watch<DateTimeProvider>().dateTimeInit
  Widget DateFilter({
    required DateTime datetime,
    required Function datetimechange,
    required ThemeProvider watchTheme,
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
                '${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                  initialDateTime: datetime,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,

                  // This shows day of week alongside day of month
                  showDayOfWeek: true,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime newDate) {
                    datetimechange(newDate);
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
                '${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                  initialDateTime: datetime,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  // This is called when the user changes the time.
                  onDateTimeChanged: (DateTime newTime) {
                    datetimechange(newTime);
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
