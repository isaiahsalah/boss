import 'package:flutter/material.dart';

class NotificationItemModel {
  String id;
  String title;
  String subtitle;
  int type;
  DateTime dateTime;
  bool state;

  NotificationItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.dateTime,
    required this.state,
  });
}
