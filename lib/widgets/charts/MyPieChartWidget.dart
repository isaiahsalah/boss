// ignore_for_file: file_names

import 'package:boss/models/ChartModel.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:boss/widgets/components/MySlidingControlWidget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MyPieChartWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<ChartDataModel> pieList;
  final List<ChartDataModel> pieListAlt;
  const MyPieChartWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.pieList,
    required this.pieListAlt,
  }) : super(key: key);
  @override
  State<MyPieChartWidget> createState() => _MyPieChartWidgetState();
}

class _MyPieChartWidgetState extends State<MyPieChartWidget> {
  int touchedIndex = -1;
  List<ChartDataModel> pieData = [];

  @override
  void initState() {
    super.initState();
    // Inicializar los datos del gráfico de dona con los datos iniciales
    pieData = widget.pieList;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return MyCardWidget(
        header: false,
        title: widget.title,
        description: widget.description,
        footer: true,
        widgetContend: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        PieChart(
                          swapAnimationDuration:
                              const Duration(milliseconds: 100),
                          swapAnimationCurve: Curves.ease,
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: AppDimensions.spacingSmall,
                            centerSpaceRadius: AppDimensions.spacingSmall * 9.5,
                            sections: showingSectionsList(
                              watchTheme: watchTheme,
                              listPieChart: pieData,
                            ),
                          ),
                        ),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              pieData
                                  .map((item) => item.value)
                                  .fold(
                                      0,
                                      (previousValue, value) =>
                                          previousValue + value.toInt())
                                  .toString(),
                              style: const TextStyle(
                                fontSize: AppDimensions.fontSizeXLong,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Bs.",
                              style: TextStyle(
                                fontSize: AppDimensions.fontSizeSmall,
                                height: 3.5,
                                color: watchTheme.colors.lightPrimary,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
            MySlidingControlWidget(
              backColor: watchTheme.colors.lightBackground,
              color: watchTheme.colors.primary,
              initialValue: 1,
              onValueChanged: (i) {
                if (i == 1) {
                  setState(() {
                    pieData = widget.pieList;
                  });
                } else {
                  setState(() {
                    pieData = widget.pieListAlt;
                  });
                }
              },
              itemsMenu: const {
                1: Text('Categoria'),
                2: Text('Producto'),
              },
            )
          ],
        ));
  }

  List<PieChartSectionData> showingSectionsList({
    required ThemeProvider watchTheme,
    required List<ChartDataModel> listPieChart,
  }) {
    return listPieChart.mapIndexed((i, itemData) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched
          ? AppDimensions.fontSizeXXSmall
          : AppDimensions.fontSizeXXSmall;
      final radius = isTouched
          ? AppDimensions.grosorLong - 10
          : AppDimensions.grosorMedium + 5;
      var shadows = [
        Shadow(color: watchTheme.colors.background, blurRadius: 2)
      ];
      return PieChartSectionData(
          color: Color((itemData.value * 0xEF927F).toInt()).withOpacity(0.7),
          value: itemData.value,
          title: '${itemData.title}\n${itemData.value.toInt()}',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            color: watchTheme.colors.white,
            shadows: shadows,
          ));
    }).toList();
  }
}

Color colorRandom() {
  math.Random random = math.Random();
  int red = random.nextInt(150) + 50;
  int green = random.nextInt(150) + 50;
  int blue = random.nextInt(150) + 50;
  return Color.fromRGBO(red, green, blue, 1);
}


/*

int totalPieChart(List<PieChartModel> item){
double total = 0;
  item.forEach((element) {
    total += element.value;
  });
  return int.parse(source);
}
*/