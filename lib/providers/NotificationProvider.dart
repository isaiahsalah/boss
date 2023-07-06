import 'package:boss/models/NotificationModel.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _listNotifications = <NotificationModel>[
    NotificationModel(
      id: '1',
      title: 'Saldo',
      subtitle: 'Description del widget',
      state: true,
    ),
    NotificationModel(
      id: '2',
      title: 'widget1',
      subtitle: 'Description del widget',
      state: true,
    ),
    NotificationModel(
      id: '3',
      title: 'widget2',
      subtitle: 'Description del widget',
      state: true,
    ),
  ];

  List<NotificationModel> get listNotifications => _listNotifications;

  Future<void> listWidgetsChange(
      List<NotificationModel> listNotifications) async {
    _listNotifications = listNotifications;
    notifyListeners();
  }
}
