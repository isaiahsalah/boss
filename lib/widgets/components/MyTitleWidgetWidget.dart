import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/widgets/components/MyPopUpInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTitleWidgetWidget extends StatelessWidget {
  final String title;
  const MyTitleWidgetWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: watchTheme.colors.lightPrimary),
            ),
            PopUpInfoWidget(
              iconPopUp: Icons.info,
              title: "Saldo Total",
              description: "Saldo Total",
            ),
          ],
        ),
        Divider(
          height: 0,
          color: watchTheme.colors.lightBackground,
        ),
      ],
    );
  }
}
