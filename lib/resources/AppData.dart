import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static List<dynamic> myListMenuSetting = [
    {
      "leading": Icon(Icons.settings_applications_sharp),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/general');
      }
    },
    {
      "leading": Icon(Icons.data_thresholding_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/widgets');
      }
    },
    {
      "leading": Icon(Icons.edit_notifications_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/notifications');
      }
    },
    {
      "leading": Icon(Icons.account_box_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/profile');
      }
    },
    {
      "leading": Icon(Icons.help_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/help');
      },
    },
    {
      "leading": Icon(Icons.logo_dev_outlined),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/about');
      },
    },
    {
      "leading": Icon(Icons.login_rounded),
      "onPressed": (context) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('username');
        Navigator.pushNamed(context, '/login');
      },
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

  static const List<dynamic> myListMenuSettingGeneral = [
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

  static const List<dynamic> myListMenuSettingAbout = [
    {
      "trailing": Text("v1.5.0"),
    },
  ];
}

class Chart {
  static const Widget leading = Icon(Icons.people);
  static const String link = "";
}
