import 'dart:convert';
import 'package:boss/models/LanguageModel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  List<String> _listLanguage = <String>['es', 'en', 'fr'];
  String _dropdownValue = "es";
  LanguageModel? _languageTexts;

  List<String> get listLanguage => _listLanguage;
  String get dropdownValue => _dropdownValue;
  LanguageModel? get languageTexts => _languageTexts;

  void languageChange({required String lang}) async {
    _dropdownValue = lang;
    _languageTexts = await cargarArchivoJson(lang: lang);
    print(cargarArchivoJson(lang: lang));
    notifyListeners();
  }

  LanguageProvider() {
    initializeLanguage();
  }

  Future<void> initializeLanguage() async {
    _languageTexts = await cargarArchivoJson(lang: "es");
    notifyListeners();
  }
}

Future<LanguageModel> cargarArchivoJson({required String lang}) async {
  String jsonString =
      await rootBundle.loadString('assets/languages/$lang.json');
  final jsonData = json.decode(jsonString);
  final languageTexts = LanguageModel.fromJson(jsonData);
  //print(languageTexts.appTitle);
  return languageTexts;
}

const List<Map<String, dynamic>> listLanguage = <Map<String, dynamic>>[
  {
    "language": 'es',
    "pages": [{}]
  },
  {
    "language": 'en',
    "pages": [{}]
  },
  {
    "language": 'fr',
    "pages": [{}]
  },
];