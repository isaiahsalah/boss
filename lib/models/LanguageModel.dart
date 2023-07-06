// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  final String appTitle;
  final String appDescription;
  final List<Chart> charts;
  final Pages pages;

  LanguageModel({
    required this.appTitle,
    required this.appDescription,
    required this.charts,
    required this.pages,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        appTitle: json["appTitle"],
        appDescription: json["appDescription"],
        charts: List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
        pages: Pages.fromJson(json["pages"]),
      );

  Map<String, dynamic> toJson() => {
        "appTitle": appTitle,
        "appDescription": appDescription,
        "charts": List<dynamic>.from(charts.map((x) => x.toJson())),
        "pages": pages.toJson(),
      };
}

class Chart {
  final String id;
  final String title;
  final String description;

  Chart({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}

class Pages {
  final Tutorial tutorial;
  final Login login;
  final Board board;
  final Notifications stats;
  final Notifications notifications;
  final Settings settings;
  final Filter filter;

  Pages({
    required this.tutorial,
    required this.login,
    required this.board,
    required this.stats,
    required this.notifications,
    required this.settings,
    required this.filter,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        tutorial: Tutorial.fromJson(json["tutorial"]),
        login: Login.fromJson(json["login"]),
        board: Board.fromJson(json["board"]),
        stats: Notifications.fromJson(json["stats"]),
        notifications: Notifications.fromJson(json["notifications"]),
        settings: Settings.fromJson(json["settings"]),
        filter: Filter.fromJson(json["filter"]),
      );

  Map<String, dynamic> toJson() => {
        "tutorial": tutorial.toJson(),
        "login": login.toJson(),
        "board": board.toJson(),
        "stats": stats.toJson(),
        "notifications": notifications.toJson(),
        "settings": settings.toJson(),
        "filter": filter.toJson(),
      };
}

class Board {
  final String title;
  final String subTitle;

  Board({
    required this.title,
    required this.subTitle,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        title: json["title"],
        subTitle: json["subTitle"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
      };
}

class Filter {
  final String title;
  final String subTitle;
  final String description;
  final DateTime dateTimeOpen;
  final DateTime dateTimeEnd;
  final String buttonCancel;
  final String buttonFilter;

  Filter({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.dateTimeOpen,
    required this.dateTimeEnd,
    required this.buttonCancel,
    required this.buttonFilter,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        title: json["title"],
        subTitle: json["subTitle"],
        description: json["description"],
        dateTimeOpen: DateTime.fromJson(json["dateTimeOpen"]),
        dateTimeEnd: DateTime.fromJson(json["dateTimeEnd"]),
        buttonCancel: json["buttonCancel"],
        buttonFilter: json["buttonFilter"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "dateTimeOpen": dateTimeOpen.toJson(),
        "dateTimeEnd": dateTimeEnd.toJson(),
        "buttonCancel": buttonCancel,
        "buttonFilter": buttonFilter,
      };
}

class DateTime {
  final String date;
  final String time;

  DateTime({
    required this.date,
    required this.time,
  });

  factory DateTime.fromJson(Map<String, dynamic> json) => DateTime(
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
      };
}

class Login {
  final String title;
  final String subTitle;
  final String userPlaceholder;
  final String passwordPlaceholder;
  final String recoverPassword;
  final String button;

  Login({
    required this.title,
    required this.subTitle,
    required this.userPlaceholder,
    required this.passwordPlaceholder,
    required this.recoverPassword,
    required this.button,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        title: json["title"],
        subTitle: json["subTitle"],
        userPlaceholder: json["userPlaceholder"],
        passwordPlaceholder: json["passwordPlaceholder"],
        recoverPassword: json["recoverPassword"],
        button: json["button"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "userPlaceholder": userPlaceholder,
        "passwordPlaceholder": passwordPlaceholder,
        "recoverPassword": recoverPassword,
        "button": button,
      };
}

class Notifications {
  final String title;
  final String subTitle;
  final List<Item> items;

  Notifications({
    required this.title,
    required this.subTitle,
    required this.items,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        title: json["title"],
        subTitle: json["subTitle"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  final String id;
  final String title;
  final String subTitle;

  Item({
    required this.id,
    required this.title,
    required this.subTitle,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        subTitle: json["subTitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTitle": subTitle,
      };
}

class Settings {
  final String title;
  final String subTitle;
  final List<Board> items;

  Settings({
    required this.title,
    required this.subTitle,
    required this.items,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        title: json["title"],
        subTitle: json["subTitle"],
        items: List<Board>.from(json["items"].map((x) => Board.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Tutorial {
  final String title;
  final String subTitle;
  final List<Item> slides;
  final Button button;

  Tutorial({
    required this.title,
    required this.subTitle,
    required this.slides,
    required this.button,
  });

  factory Tutorial.fromJson(Map<String, dynamic> json) => Tutorial(
        title: json["title"],
        subTitle: json["subTitle"],
        slides: List<Item>.from(json["slides"].map((x) => Item.fromJson(x))),
        button: Button.fromJson(json["button"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
        "button": button.toJson(),
      };
}

class Button {
  final String top;
  final String bottom;

  Button({
    required this.top,
    required this.bottom,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
        top: json["top"],
        bottom: json["bottom"],
      );

  Map<String, dynamic> toJson() => {
        "top": top,
        "bottom": bottom,
      };
}
