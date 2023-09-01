// ignore_for_file: file_names

import 'package:boss/models/notificationItem_model.dart';
import 'package:boss/providers/notificationItem_provider.dart';
import 'package:boss/providers/notification_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/widgets/main/listTile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: const DismissibleExample());
  }
}

/// Flutter code sample for [Dismissible].

class DismissibleExample extends StatefulWidget {
  const DismissibleExample({super.key});

  @override
  State<DismissibleExample> createState() => _DismissibleExampleState();
}

class _DismissibleExampleState extends State<DismissibleExample> {
  //List<int> items = List<int>.generate(20, (int index) => index);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    NotificationProvider watchNotification =
        context.watch<NotificationProvider>();
    NotificationItemProvider watchItemNotification =
        context.watch<NotificationItemProvider>();
    NotificationItemProvider readNotification =
        context.read<NotificationItemProvider>();

    List<NotificationItemModel> list =
        watchItemNotification.listItemNotifications;
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingMedium),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Opacity(
          opacity: list[index].state ? 1.0 : 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: MyListTile(
              subTitle: list[index].subtitle,
              leading: Icon(
                Icons.notification_add,
              ),
              trailing: Text(timeNotification(list[index].dateTime),
                  style: TextStyle(
                    color: watchTheme.colors.lightPrimary,
                  )),
              onPressed: () {
                list[index].state = false;
                readNotification.listItemNotificationChange(list);
                for (int i = 0;
                    i < watchNotification.listNotifications.length;
                    i++) {
                  if (watchNotification.listNotifications[i].id ==
                      list[index].type) {
                    Navigator.pushNamed(context, '/not/cashClosure');
                  }
                }
              },
              title: list[index].title,
            ),
          ),
        );
      },
    );
  }
}

String timeNotification(DateTime dateTime) {
  Duration diferencia = DateTime.now().difference(dateTime);
  String text;
  if (diferencia.inSeconds < 60) {
    text = '${diferencia.inSeconds} segundos';
  } else if (diferencia.inMinutes < 60) {
    text = '${diferencia.inMinutes} Minutos';
  } else if (diferencia.inHours < 24) {
    text = '${diferencia.inHours} horas';
  } else if (diferencia.inDays < 365) {
    text = '${diferencia.inDays} días';
  } else {
    text = 'Mucho tiempo';
  }

  return text;
}
