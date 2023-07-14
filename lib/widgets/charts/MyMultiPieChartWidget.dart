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

class MyMultiPieChartWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<ChartDataModel> pieList;
  final List<ChartDataModel> pieListAlt;
  const MyMultiPieChartWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.pieList,
    required this.pieListAlt,
  }) : super(key: key);
  @override
  State<MyMultiPieChartWidget> createState() => _MyMultiPieChartWidgetState();
}

class _MyMultiPieChartWidgetState extends State<MyMultiPieChartWidget> {
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
            pieChart(watchTheme: watchTheme),
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

  Widget pieChart({required ThemeProvider watchTheme}) {
    double listDataTotal = 0;

    for (int i = 0; i < pieData.length; i++) {
      listDataTotal += pieData[i].value;
    }

    return Column(
        children: pieData
            .map(
              (item) => Row(
                children: <Widget>[
                  SizedBox(
                    height: 140,
                    width: 140,
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
                            centerSpaceRadius: AppDimensions.spacingSmall * 4.5,
                            sections: showingSectionsList(
                              watchTheme: watchTheme,
                              listPieChart: [
                                ChartDataModel(
                                  title: "title",
                                  date: DateTime.now(),
                                  value: listDataTotal,
                                ),
                                item,
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: watchTheme.colors.lightBackground,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                  '${((item.value / listDataTotal) * 100).toInt().toString()}%'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.value.toInt().toString(),
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
                            item.title,
                            style: TextStyle(
                              fontSize: AppDimensions.fontSizeSmall,
                              color: watchTheme.colors.lightPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList());
  }

  List<PieChartSectionData> showingSectionsList({
    required ThemeProvider watchTheme,
    required List<ChartDataModel> listPieChart,
    //required ChartDataModel itemDataChart,
  }) {
    return listPieChart.mapIndexed((i, itemData) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched
          ? AppDimensions.fontSizeXXSmall
          : AppDimensions.fontSizeXXSmall;
      final radius =
          isTouched ? AppDimensions.grosorSmall : AppDimensions.grosorSmall - 5;
      var shadows = [
        Shadow(color: watchTheme.colors.background, blurRadius: 2)
      ];
      return PieChartSectionData(
          color: i == 0
              ? watchTheme.colors.background
              : watchTheme.colors.lightPrimary,
          value: itemData.value,
          showTitle: false,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            color: watchTheme.colors.white,
            shadows: shadows,
          ));
    }).toList();
  }
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