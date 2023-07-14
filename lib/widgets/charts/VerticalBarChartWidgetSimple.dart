// ignore_for_file: file_names

import 'package:boss/models/ChartModel.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalBarChartWidgetSimple extends StatefulWidget {
  final String title;
  final String description;
  final String barListTitle;
  final String barListAltTitle;
  final List<ChartDataModel> barList;
  final List<ChartDataModel> barListAlt;

  const VerticalBarChartWidgetSimple({
    Key? key,
    required this.title,
    required this.description,
    required this.barListTitle,
    required this.barListAltTitle,
    required this.barList,
    required this.barListAlt,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerticalBarChartWidgetSimpletate();
}

class VerticalBarChartWidgetSimpletate
    extends State<VerticalBarChartWidgetSimple> {
  List<ChartDataModel> pieData = [];

  @override
  void initState() {
    super.initState();
    // Inicializar los datos del gráfico de dona con los datos iniciales
    pieData = widget.barList;
  }

  double maxY() {
    double numberList1 = widget.barList.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double numberList2 = widget.barListAlt.map((item) => item.value).reduce(
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

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return MyCardWidget(
      header: false,
      title: widget.title,
      description: widget.description,
      footer: false,
      widgetContend: Column(
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
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  typeChartName(
                    color: watchTheme.colors.green,
                    title: widget.barListTitle,
                    watchTheme: watchTheme,
                    barList: widget.barList,
                  ),
                  const SizedBox(width: 20),
                  typeChartName(
                    color: watchTheme.colors.lightPrimary,
                    title: widget.barListTitle,
                    watchTheme: watchTheme,
                    barList: widget.barListAlt,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget typeChartName(
      {required Color color,
      required String title,
      required ThemeProvider watchTheme,
      required List<ChartDataModel> barList}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pieData = barList;
        });
      },
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
    );
  }

  double intervalY() {
    double numberList1 = widget.barList.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double numberList2 = widget.barListAlt.map((item) => item.value).reduce(
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
            '${pieData[value.toInt()].date.month}/${pieData[value.toInt()].date.year % 100}',
            style: style),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups({
    required ThemeProvider watchTheme,
  }) {
    return widget.barList
        .mapIndexed(
          (i, item) => BarChartGroupData(
            x: i,
            barRods: [
              pieData == widget.barList
                  ? BarChartRodData(
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                      toY: item.value,
                      gradient: LinearGradient(
                        colors: [
                          watchTheme.colors.green,
                          watchTheme.colors.lightPrimary,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY(),
                        color:
                            watchTheme.colors.lightBackground.withOpacity(0.5),
                      ))
                  : BarChartRodData(
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                      toY: widget.barListAlt[i].value,
                      gradient: LinearGradient(
                        colors: [
                          watchTheme.colors.lightBackground,
                          watchTheme.colors.lightPrimary,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY(),
                        color:
                            watchTheme.colors.lightBackground.withOpacity(0.5),
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
