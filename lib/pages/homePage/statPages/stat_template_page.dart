import 'package:boss/api/user_api.dart';
import 'package:boss/api/widgets/line_api.dart';
import 'package:boss/api/widgets/multiBox_api.dart';
import 'package:boss/api/widgets_api.dart';
import 'package:boss/builders/box_builder.dart';
import 'package:boss/builders/line_builder.dart';
import 'package:boss/builders/multiBox_builder.dart';
import 'package:boss/models/filter_model.dart';
import 'package:boss/models/module_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/widgets/widget_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/providers/user_provider.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/widgets/charts/line_widget.dart';
import 'package:boss/widgets/charts/multiBox_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatTemplatePage extends StatefulWidget {
  final ModuleModel moduleData;
  const StatTemplatePage({
    Key? key,
    required this.moduleData,
  }) : super(key: key);

  @override
  State<StatTemplatePage> createState() => _StatTemplatePageState();
}

class _StatTemplatePageState extends State<StatTemplatePage> {
  late Future<List<WidgetModel>> listWidgets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listWidgets = getListWidgets(
        token: Provider.of<UserProvider>(context, listen: false).user!.token);
  }

  Future<List<WidgetModel>> getListWidgets({required String token}) async {
    Response<dynamic> listita = await apiWidgetList(
        authToken: token, context: context, module: widget.moduleData.id);
    return widgetModelFromJson(listita.data);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider watchUser = context.watch<UserProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Módulo ${widget.moduleData.nombre}',
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(widget.moduleData.nombre,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: FutureBuilder<List<WidgetModel>>(
        future: listWidgets,
        builder:
            (BuildContext context, AsyncSnapshot<List<WidgetModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SkeletonCardWidget();
          } else if (snapshot.hasError) {
            return Text('Error al cargar los datos: ${snapshot.error}');
          } else {
            //watchLanguage.languageTexts!.pages.stats.items
            //return SkeletonMenuWidget();
            List<Widget> widgetList = [
              const SizedBox(
                height: 20,
              )
            ];
            widgetList.addAll(snapshot.data!
                .mapIndexed(
                  (i, item) => drawWidget(
                      widgetData: item,
                      context: context,
                      watchUser: watchUser,
                      watchTheme: watchTheme),
                )
                .toList());
            return ListView(
              children: widgetList,
            );
          }
        },
      ),
    );
  }

  Widget drawWidget(
      {required WidgetModel widgetData,
      required BuildContext context,
      required UserProvider watchUser,
      required ThemeProvider watchTheme}) {
    Future<WidgetDataModel> WidgetResponse;
    Future<TableModel> WidgetResponseDetail;

    /* Future<FilterModel> filtersResponse = getWidgetFiltersController(
        authToken: watchUser.user!.token, context: context, id: widgetData.id);*/

    Future<FilterModel> getPref() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString(widgetData.id.toString()) != null) {
        return filterModelFromJson(prefs.getString(widgetData.id.toString())!);
      } else {
        return getWidgetFiltersController(
            authToken: watchUser.user!.token,
            context: context,
            id: widgetData.id);
      }
    }

    Future<FilterModel> filtersResponse = getPref();
    switch (widgetData.params) {
      case "box":
        return BoxBuilder(
            filtersResponse: filtersResponse, widgetData: widgetData);

      case "mbx":
        return MultiBoxBuilder(
            filtersResponse: filtersResponse, widgetData: widgetData);

      case "lin":
        return LineBuilder(
            filtersResponse: filtersResponse, widgetData: widgetData);
      default:
        return Text("data");
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////

