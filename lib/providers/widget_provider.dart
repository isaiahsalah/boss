// ignore_for_file: file_names
import 'package:boss/models/widgets/widget_model.dart';
import 'package:flutter/material.dart';

class WidgetProvider with ChangeNotifier {
  List<WidgetModel> _listWidgets = [];

  List<WidgetModel> get listWidgets => _listWidgets;

  Future<void> listWidgetsChange(List<WidgetModel> listWidgets) async {
    _listWidgets = listWidgets;
    notifyListeners();
  }
}
