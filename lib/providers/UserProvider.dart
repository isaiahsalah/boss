import 'package:flutter/material.dart';

class UserModel {}

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void languageChange({required UserModel user}) async {
    _user = user;
    notifyListeners();
  }
}
