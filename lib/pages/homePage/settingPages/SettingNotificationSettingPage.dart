import 'package:boss/providers/NotificationSettingProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
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
    NotificationSettingProvider watchNotification =
        context.watch<NotificationSettingProvider>();

    return Scaffold(
        appBar: AppBar(),
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
