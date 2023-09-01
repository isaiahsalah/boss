// ignore_for_file: file_names
import 'package:boss/models/module_model.dart';
import 'package:flutter/material.dart';

class ModulesProvider with ChangeNotifier {
  List<ModuleModel> _listModules = [];

  List<ModuleModel> get listModules => _listModules;

  Future<void> setListModules({required List<ModuleModel> listModules}) async {
    _listModules = listModules;
    notifyListeners();
  }
}
