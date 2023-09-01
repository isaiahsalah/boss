// ignore_for_file: file_names

import 'package:boss/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _listNotifications = <NotificationModel>[
    NotificationModel(
      id: 1,
      title: 'Cierre de Cajas',
      subtitle: 'Las cajas en la sucursal 4 han cerrado',
      page: "/not/cashClosure",
      state: true,
    ),
    NotificationModel(
      id: 2,
      title: 'Stock agotado',
      subtitle: 'Un item no cuenta con stocks',
      page: "/not/cashClosure",
      state: true,
    ),
    NotificationModel(
      id: 3,
      title: 'Compras muy grandes',
      subtitle: 'Se notificarán las compras más grandes',
      page: "/not/cashClosure",
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
