import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateTimeFilter extends StatefulWidget {
  final String title;

  final DateTime dateTime;
  final Function dateTimeUpdate;

  const DateTimeFilter({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.dateTimeUpdate,
  }) : super(key: key);

  @override
  State<DateTimeFilter> createState() => _DateTimeFilterState();
}

class _DateTimeFilterState extends State<DateTimeFilter> {
  late DateTime _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    void _showDialog({required Widget child}) {
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
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
            '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
            style: const TextStyle(
              fontSize: AppDimensions.fontSizeSmall,
            ),
          ),
          onPressed: () => _showDialog(
              child: CupertinoDatePicker(
            dateOrder: DatePickerDateOrder.dmy,
            initialDateTime: _selectedDate,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: false,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
                widget.dateTimeUpdate(newDate);
              });
            },
          )),
        ),
      ],
    );
  }
}
