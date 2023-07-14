// ignore_for_file: file_names

import 'package:boss/models/ChartModel.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLineChartAltWidget extends StatefulWidget {
  final String title;
  final String description;
  final String lineListTitle;
  final String lineListAltTitle;

  final List<ChartDataModel> lineList;
  final List<ChartDataModel> lineListAlt;
  const MyLineChartAltWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.lineListTitle,
    required this.lineListAltTitle,
    required this.lineList,
    required this.lineListAlt,
  }) : super(key: key);

  @override
  State<MyLineChartAltWidget> createState() => _MyLineChartAltWidgetState();
}

class _MyLineChartAltWidgetState extends State<MyLineChartAltWidget> {
  bool showAvg = false;

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

    return MyCardWidget(
      header: false,
      title: widget.title,
      description: widget.description,
      footer: false,
      widgetContend: Column(
        children: [
          const SizedBox(
            height: AppDimensions.spacingLong,
          ),
          chartLine(
              lineListData: widget.lineList,
              title: widget.lineListTitle,
              watchTheme: watchTheme,
              gradientColors: gradientColors,
              gradientColorsAlt: gradientColorsAlt,
              screenWidth: screenWidth),
          const Divider(
            height: AppDimensions.spacingLong * 2,
          ),
          chartLine(
              lineListData: widget.lineListAlt,
              title: widget.lineListAltTitle,
              watchTheme: watchTheme,
              gradientColors: gradientColors,
              gradientColorsAlt: gradientColorsAlt,
              screenWidth: screenWidth),
          const Divider(
            height: AppDimensions.spacingLong * 2,
          ),
          chartLine(
              lineListData: widget.lineListAlt,
              title: widget.lineListAltTitle,
              watchTheme: watchTheme,
              gradientColors: gradientColors,
              gradientColorsAlt: gradientColorsAlt,
              screenWidth: screenWidth),
          const SizedBox(height: 20),
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
      required List<ChartDataModel> lineListData}) {
    return Row(
      children: [
        Stack(
          children: <Widget>[
            SizedBox(
              height: 70,
              width: (screenWidth * 0.6) - (AppDimensions.spacingMedium * 4),
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
                        fontSize: AppDimensions.fontSizeLong * 1.2,
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
    );
  }

  double tendencia(List<ChartDataModel> array) {
    double sumOfDifferences = 0.0;
    for (int i = 1; i < array.length; i++) {
      double difference = array[i].value - array[i - 1].value;
      sumOfDifferences += difference;
    }
    double averageDifference = sumOfDifferences / (array.length - 1);

    return averageDifference;
  }

  Widget bottomTitleWidgets(
    double value,
    TitleMeta meta,
    ThemeProvider watchTheme,
  ) {
    //Aquí se editan los textos del eje X

    var style = TextStyle(
      fontSize: AppDimensions.fontSizeXXSmall,
      color: watchTheme.colors.lightPrimary,
    );
    String text =
        '${widget.lineList[value.toInt()].date.day}/${widget.lineList[value.toInt()].date.month}';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(
    double value,
    TitleMeta meta,
    ThemeProvider watchTheme,
  ) {
    //Aquí se editan los textos del eje Y
    var style = TextStyle(
      fontSize: AppDimensions.fontSizeXXSmall,
      color: watchTheme.colors.lightPrimary,
    );

    return Text(reducirCantidad(value.toInt()),
        style: style, textAlign: TextAlign.left);
  }

  double minY() {
    double numberList1 = widget.lineList.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual < valorSiguiente ? valorActual : valorSiguiente);
    double numberList2 = widget.lineListAlt.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual < valorSiguiente ? valorActual : valorSiguiente);
    double number;

    if (numberList1 < numberList2) {
      number = numberList1;
    } else {
      number = numberList2;
    }
    if (number > 0) {
      number = 0;
    }
    return number;
  }

  double maxY() {
    double numberList1 = widget.lineList.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double numberList2 = widget.lineListAlt.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double number;

    if (numberList1 > numberList2) {
      number = numberList1;
    } else {
      number = numberList2;
    }

    return number;
  }

  double maxX() {
    int numberList1 = widget.lineList.length;
    int numberList2 = widget.lineListAlt.length;
    int number;

    if (numberList1 > numberList2) {
      number = numberList1;
    } else {
      number = numberList2;
    }
    return number - 1.toDouble();
  }

  double intervalY() {
    double numberList1 = widget.lineList.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double numberList2 = widget.lineListAlt.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double number;

    if (numberList1 > numberList2) {
      number = numberList1;
    } else {
      number = numberList2;
    }

    return number / 10;
  }

  double intervalX() {
    int numberList1 = widget.lineList.length;
    int numberList2 = widget.lineListAlt.length;
    int number;

    if (numberList1 > numberList2) {
      number = numberList1;
    } else {
      number = numberList2;
    }

    return number / 10.toDouble();
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
      required List<ChartDataModel> chartDataList}) {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        verticalInterval: intervalX(),
        horizontalInterval: intervalY(),
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
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 0,
            getTitlesWidget: (double double, TitleMeta titleMeta) =>
                bottomTitleWidgets(double, titleMeta, watchTheme),
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double double, TitleMeta titleMeta) =>
                leftTitleWidgets(double, titleMeta, watchTheme),
            reservedSize: 0,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: watchTheme.colors.lightBackground),
      ),
      minX: 0,
      maxX: maxX(),
      minY: minY(),
      maxY: maxY(),
      lineBarsData: [
        LineChartBarData(
          spots: chartDataList
              .mapIndexed((i, item) => FlSpot(i.toDouble(), item.value))
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
