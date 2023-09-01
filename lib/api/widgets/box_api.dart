import 'package:boss/api/widgets_api.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/widgets/widget_box_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<WidgetDataModel> getWidgetBox(
    {required String token,
    required BuildContext context,
    required Object body}) async {
  Response<dynamic> listita =
      await apiWidget(authToken: token, context: context, body: body);
  WidgetBoxModel modelBox = widgetBoxModelFromJson(listita.data);
  WidgetDataModel model = WidgetDataModel(
    titulo: modelBox.titulo,
    descripcion: modelBox.descripcion,
    contenido: [
      WidgetContentDataModel(titulo: "", descripcion: "", contenido: [
        WidgetContentContentDataModel(nombre: "", total: modelBox.ingresos),
        WidgetContentContentDataModel(nombre: "", total: modelBox.egresos),
      ]),
    ],
  );
  return model;
}

Future<TableModel> getWidgetBoxTable(
    {required String token,
    required BuildContext context,
    required Object body}) async {
  Response<dynamic> listita =
      await apiWidget(authToken: token, context: context, body: body);
  return tableModelFromJson(listita.data);
}
