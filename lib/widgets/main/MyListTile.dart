import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget leading;
  final Widget trailing;
  final Function() onPressed;

  const MyListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.trailing,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return Material(
      elevation: 4.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: ListTile(
        onTap: onPressed,
        tileColor: watchTheme.colors.primary,
        leading: leading == null ? null : leading,
        trailing: onPressed == null ? null : trailing,
        title: Text(title),
        subtitle: Text(
          subTitle,
          style: TextStyle(
            color: watchTheme.colors.lightPrimary,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
      ),
    );
  }
}
