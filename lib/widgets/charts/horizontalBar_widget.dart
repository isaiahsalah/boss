// ignore_for_file: file_names

import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/widgets/charts/functions/chart_functions.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHorizontalBarChartWidget extends StatefulWidget {
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;

  const MyHorizontalBarChartWidget({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
  }) : super(key: key);

  @override
  State<MyHorizontalBarChartWidget> createState() =>
      _MyHorizontalBarChartWidgetState();
}

class _MyHorizontalBarChartWidgetState
    extends State<MyHorizontalBarChartWidget> {
  late WidgetDataModel _dataFuture;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width < 600
        ? MediaQuery.of(context).size.width
        : 600;

    return FutureBuilder<WidgetDataModel>(
      future: widget.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<WidgetDataModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los datos');
        } else {
          _dataFuture = snapshot.data!;
          return content(width);
        }
      },
    );
  }

  Widget content(double width) {
    return CardTemplate(
        filter: Icon(Icons.abc),
        trailing: SizedBox(),
        header: true,
        data: _dataFuture,
        dataDetail: widget.dataFutureDetail,
        footer: true,
        child: Column(children: listWidget(width)));
  }

  List<Widget> listWidget(double width) {
    List<WidgetContentContentDataModel> listita =
        _dataFuture.contenido![0].contenido!;
    listita.sort((a, b) => b.total.compareTo(a.total));
    return listita
        .map((item) => MyLineBarChartWidget(
              title: item.nombre ?? "",
              quantity:
                  rowSize(item.total, ChartFuntions.maxY(_dataFuture), width),
            ))
        .take(3)
        .toList();
  }

  double rowSize(double quantity, double maxQuantity, double width) {
    final double newQuantity =
        (width - (AppDimensions.spacingMedium * 4)) / (maxQuantity / quantity);
    return newQuantity;
  }
}

class MyLineBarChartWidget extends StatelessWidget {
  final String title;
  final double quantity;
  const MyLineBarChartWidget({
    Key? key,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSizeXSmall,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      quantity.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSizeXSmall,
                      ),
                    ),
                    Text(
                      'Bs',
                      style: TextStyle(
                          fontSize: AppDimensions.fontSizeXSmall,
                          color: watchTheme.colors.lightPrimary),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: watchTheme.colors.lightBackground,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusSmall),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: watchTheme.colors.lightPrimary,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusSmall)),
                        height: 8,
                        width: quantity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
