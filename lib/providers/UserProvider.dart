// ignore_for_file: file_names

import 'package:boss/models/UserModel.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> userChange({required UserModel user}) async {
    _user = user;
    notifyListeners();
  }
}
