import 'dart:convert';
import 'dart:math';
import 'package:boss/constants/prefs_const.dart';
import 'package:boss/models/user_model.dart';
import 'package:boss/models/widgets/widget_model.dart';
import 'package:boss/constants/api_const.dart';
import 'package:boss/services/encryps_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Response<dynamic>> apiUserLogin(String user, String pass) async {
  const path = ApiConst.postUserLogin;
  var data = {'username': user, 'password': encriptadorPass(pass)};
  Response response = Response(requestOptions: RequestOptions());
  try {
    response = await Dio().post(path, data: data);
    return response;
  } catch (Exception) {
    response.statusCode = 401;

    return response;
  }
  /*try {
    //print(response.data);
    if (response.statusCode == 200) {
      //print(response.data.runtimeType);
      return response.data;
    } else {
      return response.statusCode.toString();
    }
    //return jsonEncode(response.data);
  } catch (e) {
    return response.statusCode.toString();
  }*/
}

Future<Response<dynamic>> apiUserEnterprise(
    {required int idEnterprise, required String authToken}) async {
  const path = ApiConst.postUserEnterprise;
  var data = {'Id': idEnterprise};

  Response response = await Dio().post(path,
      data: data,
      options: Options(
        headers: {"Authorization": 'Bearer $authToken'},
      ));
  return response;
  /*
  try {
    Response response = await Dio().post(path,
        data: data,
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
        ));
          return response;

    if (response.statusCode == 200) {
      //print(response.data.runtimeType);
      return response.data;
    } else {
      return "";
    }

    //return jsonEncode(response.data);
  } catch (e) {
    return "";
  }*/
}

Future<Response<dynamic>> apiModuleList({
  required String authToken,
  required BuildContext context,
}) async {
  const path = ApiConst.getModulesList;

  Response response = Response(requestOptions: RequestOptions());
  try {
    response = await Dio().get(path,
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
        ));

    return response;
  } on DioException catch (e) {
    code401(context: context, code: e.response?.statusCode ?? 0);
    return response;
  }

  /*
  try {
    Response response = await Dio().post(path,
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
        ));
          return response;
/*
    if (response.statusCode == 200) {
      //print(response.data.runtimeType);
      return response.data;
    } else {
      return "";
    }*/

    //return jsonEncode(response.data);
  } catch (e) {
    return "";
  }*/
}

Future<Response<dynamic>> apiWidgetList({
  required String authToken,
  required BuildContext context,
  required String module,
}) async {
  const path = ApiConst.getWidgetList;

  Response response = Response(requestOptions: RequestOptions());
  try {
    response = await Dio().get(path,
        data: {"Modulo": module, "Tipo": "wd"},
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
        ));

    return response;
  } on DioException catch (e) {
    code401(context: context, code: e.response?.statusCode ?? 0);
    return response;
  }
}

/*
Future<bool> apiVerifyJwtToken(String token) async {
  try {
    const path = ApiConst.postUserToken;

    var data = {'token': token};

    final response = await Dio().post(path, data: data);

    //exampleData = ExampleModel.fromJson(response.data);
    if (response.data == true) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}*/
/*
Future<dynamic> apiWidget(UserModel user) async {
  try {
    const path = '${ApiConst.postUserWidgets}';
    final response = await Dio().post(path,
        data: user.toJson(),
        options: Options(
          headers: {"Authorization": user.token},
        ));
    String jsonobject = jsonEncode(response.data);
    return widgetModelFromJson(jsonobject);
  } catch (e) {
    return null;
  }
}*/

void code401({
  required BuildContext context,
  required int code,
}) async {
  if (code == 401) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PrefsConstants.prefsUser);
    Navigator.pushNamed(context, '/login');
  }
}
