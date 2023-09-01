// ignore_for_file: file_names

import 'package:boss/providers/filterDate_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final Widget leading;
  final List<Widget> actions;

  const MyAppBarWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    DateTimeProvider watch = context.watch<DateTimeProvider>();

    void onPressedFilter() => Navigator.pushNamed(context, '/filter');

    return AppBar(
      //elevation: 3,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      titleSpacing: 5,
      leading: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingSmall),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: watchTheme.colors.lightBackground,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: leading),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subTitle,
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXXSmall,
                color: watchTheme.colors.lightPrimary,
              )),
          Text(title,
              style: const TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
              )),
        ],
      ),
      actions: actions,
    );
  }
}

List<Widget> ActionAppBar(
    {required DateTimeProvider watchFilter,
    required ThemeProvider watchTheme,
    required BuildContext context}) {
  void onPressed() => Navigator.pushNamed(context, '/filter');

  return [
    Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${watchFilter.dateTimeInit.day.toString().padLeft(2, '0')}/${watchFilter.dateTimeInit.month.toString().padLeft(2, '0')}/${watchFilter.dateTimeInit.year.toString().substring(2)}',
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            Text(
              '${watchFilter.dateTimeFin.day.toString().padLeft(2, '0')}/${watchFilter.dateTimeFin.month.toString().padLeft(2, '0')}/${watchFilter.dateTimeFin.year.toString().substring(2)}',
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            )
          ],
        ),
        const SizedBox(
          width: AppDimensions.spacingSmall,
        ),
        IconButton(
          color: watchTheme.colors.white,
          icon: const Icon(Icons.filter_list_rounded),
          onPressed: onPressed,
        ),
      ],
    ),
    const SizedBox(
      width: AppDimensions.spacingSmall,
    )
  ];
}
