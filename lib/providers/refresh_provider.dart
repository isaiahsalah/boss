// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RefreshProvider with ChangeNotifier {
  bool _refreshState = false;
  bool get filterState => _refreshState;

  Future<void> refreshStateChange() async {
    _refreshState = !_refreshState;
    notifyListeners();
  }
}
