import 'package:flutter/material.dart';

class LanguagesData {
  static const List<dynamic> myLanguagesData = [
    {
      "es": {
        "appTitle": "",
        "appDescription": "",
        "pages": {
          "board": {
            "title": "",
            "description": "",
            "charts": [
              {"id": "", "title": "", "description": ""},
              {"id": "", "title": "", "description": ""},
              {"id": "", "title": "", "description": ""},
            ]
          },
          "stats": {
            "title": "",
            "description": "",
          },
          "settings": {
            "title": "",
            "description": "",
            "menu": [
              {"id": "", "title": "", "description": ""},
              {"id": "", "title": "", "description": ""},
              {"id": "", "title": "", "description": ""},
            ]
          },
          "filter": {
            "title": "",
            "description": "",
            "dateTimeOpen": {
              "date": "",
              "time": "",
            },
            "dateTimeEnd": {
              "date": "",
              "time": "",
            },
            "menu": [
              {"id": "", "title": "", "description": ""},
              {"id": "", "title": "", "description": ""},
              {"id": "", "title": "", "description": ""},
            ]
          },
        }
      }
    },
    {
      "title": "Widgets",
      "subTitle": "Acerca de...",
      "leading": Icons.data_thresholding_rounded,
      "onPressed": '/config/widgets'
    },
    {
      "title": "Notificaciones",
      "subTitle": "Acerca de...",
      "leading": Icons.notifications_active_rounded,
      "onPressed": '/config/notifications'
    }
  ];
}
