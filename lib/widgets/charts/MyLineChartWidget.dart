// ignore_for_file: file_names

import 'package:boss/models/ChartModel.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLineChartWidget extends StatefulWidget {
  final String title;
  final String description;
  final String lineListTitle;
  final String lineListAltTitle;

  final List<ChartDataModel> lineList;
  final List<ChartDataModel> lineListAlt;
  const MyLineChartWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.lineListTitle,
    required this.lineListAltTitle,
    required this.lineList,
    required this.lineListAlt,
  }) : super(key: key);

  @override
  State<MyLineChartWidget> createState() => _MyLineChartWidgetState();
}

class _MyLineChartWidgetState extends State<MyLineChartWidget> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    List<Color> gradientColors = [
      watchTheme.colors.green,
      watchTheme.colors.lightPrimary,
    ];

    List<Color> gradientColorsAlt = [
      watchTheme.colors.active,
      watchTheme.colors.lightPrimary,
    ];
    return MyCardWidget(
      header: true,
      title: widget.title,
      description: widget.description,
      footer: false,
      widgetContend: Column(
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                height: 180,
                child: LineChart(
                  showAvg
                      ? avgData(
                          gradientColors: gradientColors,
                          gradientColorsAlt: gradientColorsAlt,
                          watchTheme: watchTheme,
                        )
                      : mainData(
                          gradientColors: gradientColors,
                          gradientColorsAlt: gradientColorsAlt,
                          watchTheme: watchTheme,
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  typeChartName(
                    color: watchTheme.colors.green,
                    title: widget.lineListTitle,
                    watchTheme: watchTheme,
                  ),
                  const SizedBox(width: 20),
                  typeChartName(
                      color: watchTheme.colors.active,
                      title: widget.lineListAltTitle,
                      watchTheme: watchTheme),
                ],
              ),
              SizedBox(
                width: 35,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  //Aquí se editan el Titulos  del eje Y
                  child: Text(
                    'avg',
                    style: TextStyle(
                      fontSize: AppDimensions.fontSizeXXSmall,
                      color: showAvg
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget typeChartName({
    required Color color,
    required String title,
    required ThemeProvider watchTheme,
  }) {
    return Row(
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
    );
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

    return number / 0.85;
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
    if (cantidad >= 1000 || cantidad <= -1000) {
      double cantidadReducida = cantidad / 1000;
      String sufijo = 'K';
      return '${cantidadReducida.toStringAsFixed(1)}$sufijo';
    } else {
      return cantidad.toString();
    }
  }

  List<ChartDataModel> avgList() {
    List<ChartDataModel> list = widget.lineList;
    List<ChartDataModel> listalt = widget.lineListAlt;
    List<ChartDataModel> avg = [];
    for (int i = 0; i < list.length; i++) {
      double normal;
      normal = (list[i].value + listalt[i].value) / 2;
      /*print(list[i].value);
      print(listalt[i].value);
      print(normal);*/
      avg.add(ChartDataModel(
        title: list[i].title,
        date: list[i].date,
        value: normal,
      ));
    }
    return avg;
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

  LineChartData mainData({
    required ThemeProvider watchTheme,
    required List<Color> gradientColors,
    required List<Color> gradientColorsAlt,
  }) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        verticalInterval: intervalX(),
        horizontalInterval: intervalY(),
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
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 1,
            getTitlesWidget: (double double, TitleMeta titleMeta) =>
                bottomTitleWidgets(double, titleMeta, watchTheme),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double double, TitleMeta titleMeta) =>
                leftTitleWidgets(double, titleMeta, watchTheme),
            reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: watchTheme.colors.lightBackground),
      ),
      minX: 0,
      maxX: maxX(),
      minY: minY(),
      maxY: maxY(),
      lineBarsData: [
        //Aqui entran los datos
        LineChartBarData(
          spots: widget.lineList
              .mapIndexed(
                (i, item) => FlSpot(i.toDouble(), item.value),
              )
              .toList(),
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.25))
                  .toList(),
            ),
          ),
        ),

        LineChartBarData(
          isCurved: false,
          color: watchTheme.colors.active,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColorsAlt
                  .map((color) => color.withOpacity(0.25))
                  .toList(),
            ),
          ),
          spots: widget.lineListAlt
              .mapIndexed(
                (i, item) => FlSpot(i.toDouble(), item.value),
              )
              .toList(),
        ),
      ],
    );
  }

  LineChartData avgData(
      {required ThemeProvider watchTheme,
      required List<Color> gradientColors,
      required List<Color> gradientColorsAlt}) {
    return LineChartData(
      //lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
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
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
            getTitlesWidget: (double, TitleMeta) =>
                bottomTitleWidgets(double, TitleMeta, watchTheme),
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
            getTitlesWidget: (double, TitleMeta) =>
                leftTitleWidgets(double, TitleMeta, watchTheme),
            reservedSize: 35,
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
        show: true,
        border: Border.all(color: watchTheme.colors.lightBackground),
      ),
      minX: 0,
      maxX: maxX(),
      minY: minY(),
      maxY: maxY(),
      lineBarsData: [
        LineChartBarData(
          spots: avgList()
              .mapIndexed((i, item) => FlSpot(i.toDouble(), item.value))
              .toList(),
          isCurved: false,
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
          barWidth: 2,
          isStrokeCapRound: true,
          //puntos en la linea
          dotData: const FlDotData(
            show: true,
          ),
          //area coloreada
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(
                        begin: watchTheme.colors.active,
                        end: watchTheme.colors.active)
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(
                        begin: watchTheme.colors.green,
                        end: watchTheme.colors.green)
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
