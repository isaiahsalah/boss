import 'package:boss/api/widgets_api.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<WidgetDataModel> getWidgetMultiBox(
    {required String token,
    required BuildContext context,
    required Object body}) async {
  Response<dynamic> listita =
      await apiWidget(authToken: token, context: context, body: body);

  return widgetDataModelFromJson(listita.data);
}

Future<TableModel> getWidgetMultiBoxTable(
    {required String token,
    required BuildContext context,
    required Object body}) async {
  Response<dynamic> listita =
      await apiWidget(authToken: token, context: context, body: body);

  return tableModelFromJson(listita.data);
}
