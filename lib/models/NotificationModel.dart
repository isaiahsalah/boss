import 'package:flutter/material.dart';

class NotificationModel {
  int id;
  String title;
  String subtitle;
  String page;
  bool state;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.state,
  });
}
