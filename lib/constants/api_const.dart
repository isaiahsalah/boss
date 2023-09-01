class ApiConst {
  //url o ip fe API
  static const String baseUrl = 'http://192.168.1.9/WSSingletonBoss/api';

  //url de controllers
  static const String _user = '$baseUrl/user';
  static const String _widget = '$baseUrl/widget';
  static const String _modgn = '$baseUrl/modgn';

  //modulos
  static const String _module = '$_modgn/modulo';

  //objets
  static const String _objets = '$_modgn/objeto';

  //End Points

  static const String getWidgetFilters = '$_modgn/objeto';

  //url user de funciones
  static const String postUserLogin = '$_user/login';
  static const String postUserEnterprise = '$_user/empresa';

  //widgets
  static const String getWidget = '$_objets/widget';
  static const String getWidgetList = '$_objets/lista';

  //modulos
  static const String getModulesList = '$_module/lista';

  /////////////////////////////////////////////////////////////////////////

  static const String postUserToken = '$_user/validate-token';
  static const String postUserWidgets = '$_user/widgets';
  //url widgets de funciones
  static const String widgetGeneral = '$_widget/general';

  //url Widgets General
  static const String postWidgetGeneralBoxes = '$widgetGeneral/boxes';
  static const String postWidgetGeneralBalance = '$widgetGeneral/balance';
  static const String postWidgetDetailGeneralBalance =
      '$widgetGeneral/balance-detail';
}
