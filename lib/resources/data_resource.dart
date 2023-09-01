// ignore_for_file: file_names

import 'package:boss/constants/prefs_const.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static List<dynamic> myListMenuSetting = [
    {
      "title": "General",
      "subTitle": "Descipción General bla",
      "leading": const Icon(Icons.settings_applications_sharp),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/general');
      }
    },
    {
      "title": "Widgets",
      "subTitle": "Descripcjión Widgets",
      "leading": const Icon(Icons.data_thresholding_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/widgets');
      }
    },
    {
      "title": "Notificación",
      "subTitle": "Acerca de...",
      "leading": const Icon(Icons.edit_notifications_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/notifications');
      }
    },
    {
      "title": "Perfil",
      "subTitle": "Acerca de...",
      "leading": const Icon(Icons.account_box_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/profile');
      }
    },
    {
      "title": "Ayuda y soporte",
      "subTitle": "Acerca de...",
      "leading": const Icon(Icons.help_rounded),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/help');
      },
    },
    {
      "title": "Acerda de...",
      "subTitle": "Acerca de...",
      "leading": const Icon(Icons.logo_dev_outlined),
      "onPressed": (context) {
        Navigator.pushNamed(context, '/config/about');
      },
    },
    {
      "title": "Cerrar Sesión",
      "subTitle": "Puedes inicar con otra cuenta o en otro momento.",
      "leading": const Icon(Icons.login_rounded),
      "onPressed": (context) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        //prefs.remove(PrefsConstants.prefsUser);
        Navigator.pushNamed(context, '/login');
      },
    },
  ];
/*
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
*/
  static const List<dynamic> myListMenuSettingGeneral = [
    {
      "title": "Configuraciones",
      "subtitle": "Configura las  variables de Boss",
      "trailing": Icon(Icons.attach_money_rounded),
    },
    {
      "title": "Configuraciones",
      "subtitle": "Configura las  variables de Boss",
      "trailing": Icon(Icons.attach_money_rounded),
    },
    {
      "title": "Configuraciones",
      "subtitle": "Configura las  variables de Boss",
      "trailing": Icon(Icons.attach_money_rounded),
    },
    {
      "title": "Configuraciones",
      "subtitle": "Configura las  variables de Boss",
      "trailing": Icon(Icons.attach_money_rounded),
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
