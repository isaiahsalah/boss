// ignore_for_file: file_names

import 'package:boss/models/notificationItem_model.dart';
import 'package:flutter/material.dart';

class NotificationItemProvider with ChangeNotifier {
  List<NotificationItemModel> _listItemNotifications = <NotificationItemModel>[
    NotificationItemModel(
        id: '1',
        type: 1,
        title: 'Cierre de Cajas',
        subtitle: 'Las cajas en la sucursal 4 han cerrado',
        state: true,
        dateTime: DateTime(2023, 7, 9, 10, 30)),
    NotificationItemModel(
        id: '2',
        type: 1,
        title: 'Stock agotado',
        subtitle: 'Un item no cuenta con stocks',
        state: true,
        dateTime: DateTime(2023, 7, 10, 10, 30)),
    NotificationItemModel(
        id: '3',
        type: 1,
        title: 'Cierre de Cajas',
        subtitle: 'Las cajas en la sucursal 2 han cerrado',
        state: true,
        dateTime: DateTime(2023, 7, 11, 8, 30)),
    NotificationItemModel(
        id: '4',
        type: 1,
        title: 'Cierre de Cajas',
        subtitle: 'Las cajas en la sucursal 2 han cerrado',
        state: true,
        dateTime: DateTime(2023, 7, 11, 8, 30)),
    NotificationItemModel(
        id: '5',
        type: 1,
        title: 'Cierre de Cajas',
        subtitle: 'Las cajas en la sucursal 2 han cerrado',
        state: true,
        dateTime: DateTime(2023, 7, 11, 8, 30)),
    NotificationItemModel(
        id: '6',
        type: 1,
        title: 'Cierre de Cajas',
        subtitle: 'Las cajas en la sucursal 2 han cerrado',
        state: false,
        dateTime: DateTime(2023, 7, 11, 8, 30)),
  ];

  List<NotificationItemModel> get listItemNotifications =>
      _listItemNotifications;

  Future<void> listItemNotificationChange(
      List<NotificationItemModel> listItemNotifications) async {
    _listItemNotifications = listItemNotifications;
    notifyListeners();
  }
}
