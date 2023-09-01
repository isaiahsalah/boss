import 'package:boss/api/widgets/line_api.dart';
import 'package:boss/functions/filter_funtions.dart';
import 'package:boss/models/filter_model.dart';
import 'package:boss/models/request_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/widgets/widget_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/providers/user_provider.dart';
import 'package:boss/widgets/charts/line_widget.dart';
import 'package:boss/widgets/charts/multiBox_widget.dart';
import 'package:boss/widgets/components/notFound_widget.dart';
import 'package:boss/widgets/filterTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineBuilder extends StatefulWidget {
  final Future<FilterModel> filtersResponse;
  final WidgetModel widgetData;
  const LineBuilder({
    Key? key,
    required this.filtersResponse,
    required this.widgetData,
  }) : super(key: key);

  @override
  State<LineBuilder> createState() => _LineBuilderState();
}

class _LineBuilderState extends State<LineBuilder> {
  @override
  Widget build(BuildContext context) {
    UserProvider watchUser = context.watch<UserProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return FutureBuilder<FilterModel>(
      future: widget.filtersResponse,
      builder: (BuildContext context, AsyncSnapshot<FilterModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return NotFound();
        } else {
          List<FiltroEspecifico> filters = snapshot.data!.filtros;
          //ListFilterDetail(listFilter: filters);
          Future<WidgetDataModel> WidgetResponse = getWidgetLine(
              token: watchUser.user!.token,
              context: context,
              body: requestModelToJson(RequestModel(
                id: widget.widgetData.id,
                tipo: widget.widgetData.params,
                variables: ListFilterDetail(listFilter: filters),
              )));

          Future<TableModel> WidgetResponseDetail = getWidgetLineTable(
              token: watchUser.user!.token,
              context: context,
              body: requestModelToJson(RequestModel(
                id: widget.widgetData.id,
                tipo: "tbl",
                variables: ListFilterDetail(listFilter: filters),
              )));
/*
          Widget filterWidget = FilterTemplate(
            filter: snapshot.data!,
          );*/
          Widget filterWidget = FilterTemplate(
              context: context,
              filterModel: snapshot.data!,
              watchTheme: watchTheme,
              setState: setState);
          return LineWidget(
            dataFuture: WidgetResponse,
            dataFutureDetail: WidgetResponseDetail,
            filter: filterWidget,
          );
        }
      },
    );
  }
}
