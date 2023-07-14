import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/NotificationProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> list = <dynamic>[
    {
      "name": "uno",
      "state": true,
    },
    {
      "name": "dos",
      "state": false,
    },
    {
      "name": "tres",
      "state": true,
    },
  ];
  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

    NotificationProvider watchNotification =
        context.watch<NotificationProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  watchLanguage.languageTexts!.pages.settings.pages.notification
                      .subTitle,
                  style: TextStyle(
                    fontSize: AppDimensions.fontSizeXXSmall,
                    color: watchTheme.colors.lightPrimary,
                  )),
              Text(
                  watchLanguage
                      .languageTexts!.pages.settings.pages.notification.title,
                  style: TextStyle(
                    fontSize: AppDimensions.fontSizeSmall,
                  )),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          child: Container(
              decoration: BoxDecoration(
                  color: watchTheme.colors.primary,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.spacingSmall)),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: watchNotification.listNotifications
                      .mapIndexed(
                        (i, notification) => Column(
                          children: [
                            MyListTileGeneralWidget(
                              title: notification.title,
                              subtitle: notification.subtitle,
                              trailing: Switch(
                                activeColor: watchTheme.colors.white,
                                activeTrackColor:
                                    watchTheme.colors.lightPrimary,
                                inactiveThumbColor: watchTheme.colors.primary,
                                inactiveTrackColor:
                                    watchTheme.colors.lightBackground,
                                trackOutlineColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                value: notification.state,
                                onChanged: (bool state) {
                                  setState(() {
                                    var listWidgets =
                                        watchNotification.listNotifications;
                                    listWidgets[i].state = state;
                                    watchNotification
                                        .listWidgetsChange(listWidgets);
                                  });
                                },
                              ),
                            ),
                            Divider(
                              height: 0,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              )),
        ));
  }
}
