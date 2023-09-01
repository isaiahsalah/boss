import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static final Future<SharedPreferences> prefs =
      SharedPreferences.getInstance();

  //url o ip fe API
  static const String baseUrl = 'https://192.168.1.193:7225/api';

  //url de controllers
  static const String user = '$baseUrl/user';
  static const String widget = '$baseUrl/widget';

  //url user de funciones
  static const String postUserLogin = '$user/login';
  static const String postUserToken = '$user/validate-token';
  static const String postUserWidgets = '$user/widgets';

  //url widgets de funciones
  static const String widgetGeneral = '$widget/general';

//url Widgets General
  static const String postWidgetGeneralBoxes = '$widgetGeneral/boxes';
  static const String postWidgetGeneralBalance = '$widgetGeneral/balance';
}
