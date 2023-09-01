// ignore_for_file: file_names

import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/charts/functions/chart_functions.dart';
import 'package:boss/widgets/components/slidingControl_widget.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLineChartAltWidget extends StatefulWidget {
  final Future<List<WidgetDataModel>> listDataFuture;
  final Future<TableModel> dataFutureDetail;

  const MyLineChartAltWidget({
    Key? key,
    required this.listDataFuture,
    required this.dataFutureDetail,
  }) : super(key: key);

  @override
  State<MyLineChartAltWidget> createState() => _MyLineChartAltWidgetState();
}

class _MyLineChartAltWidgetState extends State<MyLineChartAltWidget> {
  //bool showAvg = false;
  late List<WidgetDataModel> _listDataFuture;
  late WidgetDataModel _dataFuture;
  int indexSelectedContent = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    double screenWidth = MediaQuery.of(context).size.width;

    List<Color> gradientColors = [
      watchTheme.colors.active,
      watchTheme.colors.lightPrimary,
    ];

    List<Color> gradientColorsAlt = [
      watchTheme.colors.green,
      watchTheme.colors.lightPrimary,
    ];

    return FutureBuilder<List<WidgetDataModel>>(
      future: widget.listDataFuture,
      builder: (BuildContext context,
          AsyncSnapshot<List<WidgetDataModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los datos');
        } else {
          _listDataFuture = snapshot.data!;
          _dataFuture = snapshot.data![indexSelectedContent];

          return content(
            watchTheme: watchTheme,
            gradientColors: gradientColors,
            gradientColorsAlt: gradientColorsAlt,
            screenWidth: screenWidth,
          );
        }
      },
    );
  }

  Widget content({
    required ThemeProvider watchTheme,
    required List<Color> gradientColors,
    required List<Color> gradientColorsAlt,
    required double screenWidth,
  }) {
    Map<int, Widget> itemsMenu = _listDataFuture
        .mapIndexed((i, branch) => Text(branch.titulo))
        .toList()
        .asMap();
    return CardTemplate(
      filter: Icon(Icons.abc),
      trailing: SizedBox(),
      header: true,
      data: _dataFuture,
      dataDetail: widget.dataFutureDetail,
      footer: true,
      child: Column(
        children: [
          Column(
              children: _dataFuture.contenido!
                  .map(
                    (line) => chartLine(
                        lineListData: line.contenido!,
                        title: line.titulo,
                        watchTheme: watchTheme,
                        gradientColors: gradientColors,
                        gradientColorsAlt: gradientColorsAlt,
                        screenWidth: screenWidth),
                  )
                  .toList()),
          const SizedBox(
            height: AppDimensions.spacingLong,
          ),
          MySlidingControlWidget(
            backColor: watchTheme.colors.lightBackground,
            color: watchTheme.colors.primary,
            initialValue: indexSelectedContent,
            onValueChanged: (index) {
              setState(() {
                _dataFuture = _listDataFuture[index];
                indexSelectedContent = index;
              });
            },
            itemsMenu: itemsMenu,
          )
        ],
      ),
    );
  }

  Widget chartLine(
      {required watchTheme,
      required double screenWidth,
      required String title,
      required List<Color> gradientColors,
      required List<Color> gradientColorsAlt,
      required List<WidgetContentContentDataModel> lineListData}) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      child: Row(
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                height: 70,
                width: (screenWidth * 0.5) - (AppDimensions.spacingMedium * 4),
                child: LineChart(
                  chartData(
                    gradientColors: gradientColors,
                    gradientColorsAlt: gradientColorsAlt,
                    watchTheme: watchTheme,
                    chartDataList: lineListData,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        tendencia(lineListData) > 0
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        color: tendencia(lineListData) > 0
                            ? watchTheme.colors.green
                            : watchTheme.colors.red,
                        size: AppDimensions.fontSizeLong,
                      ),
                      Text(
                        tendencia(lineListData).toInt().toString(),
                        style: const TextStyle(
                          fontSize: AppDimensions.fontSizeLong,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Bs",
                        style: TextStyle(
                            fontSize: AppDimensions.fontSizeSmall,
                            color: watchTheme.colors.lightPrimary,
                            height: 2.9),
                      ),
                    ],
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppDimensions.fontSizeSmall,
                      color: watchTheme.colors.lightPrimary,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double tendencia(List<WidgetContentContentDataModel> array) {
    double sumOfDifferences = 0.0;
    for (int i = 1; i < array.length; i++) {
      double difference = array[i].total - array[i - 1].total;
      sumOfDifferences += difference;
    }
    double averageDifference = sumOfDifferences / (array.length - 1);

    return averageDifference;
  }

  double maxValue(List<List<WidgetContentContentDataModel>> list) {
    double maxNum = list[0][0].total;
    for (List<WidgetContentContentDataModel> line in list) {
      for (WidgetContentContentDataModel item in line) {
        if (maxNum < item.total) {
          maxNum = item.total;
        }
      }
    }

    return maxNum;
  }

  double minValue(List<List<WidgetContentContentDataModel>> list) {
    double minNum = list[0][0].total;

    for (List<WidgetContentContentDataModel> line in list) {
      for (WidgetContentContentDataModel item in line) {
        if (minNum > item.total) {
          minNum = item.total;
        }
      }
    }
    return minNum;
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

  LineChartData chartData(
      {required ThemeProvider watchTheme,
      required List<Color> gradientColors,
      required List<Color> gradientColorsAlt,
      required List<WidgetContentContentDataModel> chartDataList}) {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        verticalInterval: ChartFuntions.intervalX(_dataFuture),
        horizontalInterval: ChartFuntions.intervalY(_dataFuture),
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: watchTheme.colors.lightBackground,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: watchTheme.colors.lightBackground,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 0,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 0,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: watchTheme.colors.lightBackground),
      ),
      minX: 0,
      maxX: ChartFuntions.maxX(_dataFuture),
      minY: ChartFuntions.minY(_dataFuture),
      maxY: ChartFuntions.maxY(_dataFuture),
      lineBarsData: [
        LineChartBarData(
          spots: chartDataList
              .mapIndexed((i, item) => FlSpot(i.toDouble(), item.total))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(
                      begin: watchTheme.colors.active,
                      end: watchTheme.colors.green)
                  .lerp(0.2)!,
              ColorTween(
                      begin: watchTheme.colors.green,
                      end: watchTheme.colors.active)
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          //puntos en la linea
          dotData: const FlDotData(
            show: false,
          ),
          //area coloreada
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: [
                ColorTween(
                        begin: watchTheme.colors.active,
                        end: Colors.transparent)
                    .lerp(0.2)!
                    .withOpacity(0.2),
                ColorTween(
                        begin: watchTheme.colors.green, end: Colors.transparent)
                    .lerp(0.2)!
                    .withOpacity(0.2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
