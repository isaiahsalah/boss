import 'package:boss/providers/FilterDateProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final Widget leading;
  final bool filter;

  const MyAppBarWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.filter,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    DateTimeProvider watch = context.watch<DateTimeProvider>();

    void onPressedFilter() => {Navigator.pushNamed(context, '/filter')};

    return AppBar(
      elevation: 3,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      titleSpacing: 5,
      leading: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingSmall),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: watchTheme.colors.lightPrimary,
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
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
              )),
        ],
      ),
      actions: [
        filter
            ? Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${watch.dateTimeInit.day.toString().padLeft(2, '0')}/${watch.dateTimeInit.month.toString().padLeft(2, '0')}/${watch.dateTimeInit.year}',
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeXXSmall,
                          color: watchTheme.colors.lightPrimary,
                        ),
                      ),
                      Text(
                        '${watch.dateTimeFin.day.toString().padLeft(2, '0')}/${watch.dateTimeFin.month.toString().padLeft(2, '0')}/${watch.dateTimeFin.year}',
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeXXSmall,
                          color: watchTheme.colors.lightPrimary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: AppDimensions.spacingSmall,
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_alt),
                    onPressed: onPressedFilter,
                  ),
                ],
              )
            : SizedBox(),
        SizedBox(
          width: AppDimensions.spacingSmall,
        )
      ],
    );
  }
}
