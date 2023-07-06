import 'package:boss/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyComboBoxWidget extends StatelessWidget {
  final List<String> listData;
  final String dropdownValue;
  final void Function(String?)? onChange;

  const MyComboBoxWidget({
    Key? key,
    required this.listData,
    required this.dropdownValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 16,
      style: TextStyle(color: watchTheme.colors.lightPrimary),
      underline: Container(
        height: 1,
        color: watchTheme.colors.lightPrimary,
      ),
      onChanged: onChange,
      items: listData.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
