import 'package:flutter/material.dart';
import 'dart:convert';

class AppData {
  static const List<dynamic> myListMenuGeneral = [
    {
      "leading": Icon(Icons.settings_applications_sharp),
      "onPressed": '/config/general'
    },
    {
      "leading": Icon(Icons.data_thresholding_rounded),
      "onPressed": '/config/widgets'
    },
    {
      "leading": Icon(Icons.notifications_active_rounded),
      "onPressed": '/config/notifications'
    },
    {
      "leading": Icon(Icons.account_box_rounded),
      "onPressed": '/config/profile'
    },
    {
      "leading": Icon(Icons.help_rounded),
      "onPressed": '/config/help',
    },
    {
      "leading": Icon(Icons.logo_dev_outlined),
      "onPressed": '/config/about',
    },
  ];

  static const List<dynamic> myListMenuStats = [
    {
      "leading": Icon(Icons.attach_money_rounded),
      "onPressed": '/stat/finance',
    },
    {
      "leading": Icon(Icons.point_of_sale_rounded),
      "onPressed": '/stat/sales',
    },
    {
      "leading": Icon(Icons.shopping_bag_rounded),
      "onPressed": '/stat/shopping',
    },
    {
      "leading": Icon(Icons.production_quantity_limits_rounded),
      "onPressed": '/stat/production',
    },
    {
      "leading": Icon(Icons.people),
      "onPressed": '/stat/humanResources',
    },
  ];
}

class Chart {
  static const Widget leading = Icon(Icons.people);
  static const String link = "";
}
