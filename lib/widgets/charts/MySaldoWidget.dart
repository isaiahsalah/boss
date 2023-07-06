import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyPopUpInfoWidget.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:boss/widgets/components/MyTitleWidgetWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBalanceWidget extends StatelessWidget {
  final String title;
  final String description;
  final int entryMoney;
  final int exitMoney;
  const MyBalanceWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.entryMoney,
    required this.exitMoney,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return MyCardWidget(
      title: title,
      description: description,
      footer: false,
      widgetContend: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                (entryMoney + exitMoney).toString(),
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, height: 0),
              ),
              SizedBox(width: 4),
              Text(
                "Bs.",
                style: TextStyle(
                  height: 3.9,
                ),
              ),
            ],
          ),
          Card(
            color: Color(0xff627B8E),
            surfaceTintColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Ingresos("Ingresos", entryMoney, true),
                  SizedBox(
                    height: 60,
                    child: VerticalDivider(
                      thickness: 2.5,
                      color: watchTheme.colors.primary,
                    ),
                  ),
                  Ingresos("Egresos", exitMoney, false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget Ingresos(String title, int money, bool entry) {
  return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            entry
                ? Icon(
                    Icons.arrow_upward_rounded,
                    color: Color(0xff9EDBA2),
                  )
                : Icon(
                    Icons.arrow_downward_rounded,
                    color: Color(0xffEF927F),
                  ),
            Text(
              title,
              style: TextStyle(height: 2.3, color: Color(0xffA7B5BF)),
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              money.toString(),
              style: TextStyle(
                fontSize: 25,
                height: 0,
              ),
            ),
            SizedBox(width: 2),
            Text(
              "Bs.",
              style: TextStyle(
                fontSize: 12,
                height: 2.3,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
