import 'dart:ffi';

import 'package:boss/api/user_api.dart';
import 'package:boss/constants/api_const.dart';
import 'package:boss/models/filter_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/widgets/widget_box_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<FilterModel> getWidgetFiltersController({
  required String authToken,
  required BuildContext context,
  required int id,
}) async {
  const path = ApiConst.getWidgetFilters;

  Response response = Response(requestOptions: RequestOptions());
  try {
    response = await Dio().get(path,
        data: {"Id": id},
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
        ));

    //print(response.data);
    return filterModelFromJson(response.data);
  } on DioException catch (e) {
    code401(context: context, code: e.response?.statusCode ?? 0);
    return filterModelFromJson(response.data);
  }
}

/////////////////////////////////////////////////////

Future<Response<dynamic>> apiWidget({
  required String authToken,
  required BuildContext context,
  required Object body,
}) async {
  const path = ApiConst.getWidget;

  Response response = Response(requestOptions: RequestOptions());
  try {
    response = await Dio().get(path,
        data: body,
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
        ));

    return response;
  } on DioException catch (e) {
    code401(context: context, code: e.response?.statusCode ?? 0);
    return response;
  }
}
