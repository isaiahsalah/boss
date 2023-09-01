// ignore_for_file: file_names

import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/resources/listColor_resource.dart';
import 'package:boss/widgets/charts/functions/chart_functions.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalBarChartWidgetSimple extends StatefulWidget {
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;

  const VerticalBarChartWidgetSimple({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerticalBarChartWidgetSimpletate();
}

class VerticalBarChartWidgetSimpletate
    extends State<VerticalBarChartWidgetSimple> {
  late WidgetDataModel _dataFuture;
  late WidgetContentDataModel _dataFutureContent;
  int indexSelectedContent = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return FutureBuilder<WidgetDataModel>(
      future: widget.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<WidgetDataModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los datos');
        } else {
          _dataFutureContent = snapshot.data!.contenido![indexSelectedContent];
          _dataFuture = snapshot.data!;
          return content(watchTheme: watchTheme);
        }
      },
    );
  }

  Widget content({required ThemeProvider watchTheme}) {
    return CardTemplate(
      filter: Icon(Icons.abc),
      trailing: SizedBox(),
      header: true,
      data: _dataFuture,
      dataDetail: widget.dataFutureDetail,
      footer: true,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                barTouchData: getBarTouchData(watchTheme: watchTheme),
                titlesData: getTitlesData(watchTheme: watchTheme),
                borderData: getBorderData(),
                barGroups: getBarGroups(watchTheme: watchTheme),
                gridData: FlGridData(
                  show: false,
                  drawVerticalLine: false,
                  horizontalInterval: ChartFuntions.intervalY(_dataFuture),
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: watchTheme.colors.lightBackground,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: watchTheme.colors.lightBackground,
                      strokeWidth: 1,
                    );
                  },
                ),
                alignment: BarChartAlignment.spaceAround,
                maxY: ChartFuntions.maxY(_dataFuture),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _dataFuture.contenido!
                  .mapIndexed(
                    (i, item) => typeChartName(
                      color: ListColor.colors[i],
                      title: item.titulo,
                      watchTheme: watchTheme,
                      index: i,
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }

  Widget typeChartName(
      {required Color color,
      required String title,
      required ThemeProvider watchTheme,
      required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexSelectedContent = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingSmall / 2),
        child: Row(
          children: [
            Container(
              width: AppDimensions.fontSizeXSmall,
              height: AppDimensions.fontSizeXSmall,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: color,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                  fontSize: AppDimensions.fontSizeXSmall,
                  color: watchTheme.colors.lightPrimary),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData getBarTouchData({required ThemeProvider watchTheme}) {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 5,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            TextStyle(
                color: watchTheme.colors.white,
                fontSize: AppDimensions.fontSizeXXSmall),
          );
        },
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta, ThemeProvider watchTheme) {
    final style = TextStyle(
      color: watchTheme.colors.lightPrimary,
      fontSize: AppDimensions.fontSizeXXSmall,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 7,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
            _dataFutureContent.contenido![value.toInt()].descripcion ?? "",
            style: style),
        /*
        child: Text(
            '${_dataFutureContent.contenido![value.toInt()].datetime!.month}/${_dataFutureContent.contenido![value.toInt()].datetime!.year % 100}',
            style: style),*/
      ),
    );
  }

  List<BarChartGroupData> getBarGroups({
    required ThemeProvider watchTheme,
  }) {
    return _dataFutureContent.contenido!
        .mapIndexed(
          (i, item) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                  toY: item.total,
                  gradient: LinearGradient(
                    colors: [
                      watchTheme.colors.lightPrimary,
                      ListColor.colors[indexSelectedContent],
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: ChartFuntions.maxY(_dataFuture),
                    color: watchTheme.colors.lightBackground.withOpacity(0.5),
                  ))
            ],
          ),
        )
        .toList();
  }

  FlTitlesData getTitlesData({required ThemeProvider watchTheme}) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          getTitlesWidget: (double double, TitleMeta titleMeta) =>
              getTitles(double, titleMeta, watchTheme),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 45,
          getTitlesWidget: (double double, TitleMeta titleMeta) =>
              getTitlesY(double, titleMeta, watchTheme),
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  Widget getTitlesY(double value, TitleMeta meta, ThemeProvider watchTheme) {
    final style = TextStyle(
      color: watchTheme.colors.lightPrimary,
      fontSize: AppDimensions.fontSizeXXSmall,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 7,
      child: Text(reducirCantidad(value.toInt()), style: style),
    );
  }

  FlBorderData getBorderData() {
    return FlBorderData(
      show: false,
    );
  }

  String reducirCantidad(int cantidad) {
    if (cantidad >= 1000) {
      double cantidadReducida = cantidad / 1000;
      String sufijo = 'K';
      return '${cantidadReducida.toStringAsFixed(1)}$sufijo';
    } else {
      return cantidad.toString();
    }
  }
}
