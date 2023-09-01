// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ApiDataProvider with ChangeNotifier {
  Future<String> _balance = "" as Future<String>;

  Future<String> get balance => _balance;

  Future<void> balanceChange({required Future<String> balance}) async {
    _balance = balance;
    notifyListeners();
  }
}
