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
  final LanguageModelPages pages;

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
        pages: LanguageModelPages.fromJson(json["pages"]),
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

class LanguageModelPages {
  final Tutorial tutorial;
  final Login login;
  final Board board;
  final Notifications stats;
  final Notifications notifications;
  final Settings settings;
  final Filter filter;

  LanguageModelPages({
    required this.tutorial,
    required this.login,
    required this.board,
    required this.stats,
    required this.notifications,
    required this.settings,
    required this.filter,
  });

  factory LanguageModelPages.fromJson(Map<String, dynamic> json) =>
      LanguageModelPages(
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
  final NotificationsPages? pages;

  Notifications({
    required this.title,
    required this.subTitle,
    required this.items,
    this.pages,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        title: json["title"],
        subTitle: json["subTitle"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        pages: json["pages"] == null
            ? null
            : NotificationsPages.fromJson(json["pages"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pages": pages?.toJson(),
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

class NotificationsPages {
  final About finance;
  final Widget sales;
  final About purchases;
  final About production;
  final About humanResources;
  final About about;

  NotificationsPages({
    required this.finance,
    required this.sales,
    required this.purchases,
    required this.production,
    required this.humanResources,
    required this.about,
  });

  factory NotificationsPages.fromJson(Map<String, dynamic> json) =>
      NotificationsPages(
        finance: About.fromJson(json["finance"]),
        sales: Widget.fromJson(json["sales"]),
        purchases: About.fromJson(json["purchases"]),
        production: About.fromJson(json["production"]),
        humanResources: About.fromJson(json["humanResources"]),
        about: About.fromJson(json["about"]),
      );

  Map<String, dynamic> toJson() => {
        "finance": finance.toJson(),
        "sales": sales.toJson(),
        "purchases": purchases.toJson(),
        "production": production.toJson(),
        "humanResources": humanResources.toJson(),
        "about": about.toJson(),
      };
}

class About {
  final String title;
  final String subTitle;
  final List<Board> options;

  About({
    required this.title,
    required this.subTitle,
    required this.options,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        title: json["title"],
        subTitle: json["subTitle"],
        options:
            List<Board>.from(json["options"].map((x) => Board.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Widget {
  final String title;
  final String subTitle;
  final List<Option> options;

  Widget({
    required this.title,
    required this.subTitle,
    required this.options,
  });

  factory Widget.fromJson(Map<String, dynamic> json) => Widget(
        title: json["title"],
        subTitle: json["subTitle"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  final int id;
  final String title;
  final String subTitle;

  Option({
    required this.id,
    required this.title,
    required this.subTitle,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
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
  final SettingsPages pages;
  final List<Board> items;

  Settings({
    required this.title,
    required this.subTitle,
    required this.pages,
    required this.items,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        title: json["title"],
        subTitle: json["subTitle"],
        pages: SettingsPages.fromJson(json["pages"]),
        items: List<Board>.from(json["items"].map((x) => Board.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "pages": pages.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class SettingsPages {
  final About general;
  final Widget widget;
  final About notification;
  final About profile;
  final About help;
  final About about;

  SettingsPages({
    required this.general,
    required this.widget,
    required this.notification,
    required this.profile,
    required this.help,
    required this.about,
  });

  factory SettingsPages.fromJson(Map<String, dynamic> json) => SettingsPages(
        general: About.fromJson(json["general"]),
        widget: Widget.fromJson(json["widget"]),
        notification: About.fromJson(json["notification"]),
        profile: About.fromJson(json["profile"]),
        help: About.fromJson(json["help"]),
        about: About.fromJson(json["about"]),
      );

  Map<String, dynamic> toJson() => {
        "general": general.toJson(),
        "widget": widget.toJson(),
        "notification": notification.toJson(),
        "profile": profile.toJson(),
        "help": help.toJson(),
        "about": about.toJson(),
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
