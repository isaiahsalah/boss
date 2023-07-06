import 'package:boss/models/NotificationModel.dart';
import 'package:boss/providers/NotificationProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppResources.dart';
import 'package:boss/widgets/main/MyListTile.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissibleExample();
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
    NotificationProvider readNotification =
        context.read<NotificationProvider>();

    List<NotificationModel> list = watchNotification.listNotifications;
    return ListView.builder(
      padding: EdgeInsets.all(AppDimensions.spacingMedium),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            color: Colors.transparent,
          ),
          key: ValueKey<int>(int.parse(list[index].id)),
          onDismissed: (DismissDirection direction) {
            setState(() {
              print(list);
              list.removeAt(index);
              print(list);
              readNotification.listWidgetsChange(list);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: MyListTile(
              subTitle: list[index].subtitle,
              leading: Icon(Icons.notification_add),
              trailing: Text("5 seg",
                  style: TextStyle(
                    color: watchTheme.colors.lightPrimary,
                  )),
              onPressed: () {},
              title: list[index].title,
            ),
          ),
        );
      },
    );
  }
}
