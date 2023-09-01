// ignore_for_file: file_names

import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/components/slidingControl_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MyPieChartWidget extends StatefulWidget {
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;

  const MyPieChartWidget({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
  }) : super(key: key);
  @override
  State<MyPieChartWidget> createState() => _MyPieChartWidgetState();
}

class _MyPieChartWidgetState extends State<MyPieChartWidget> {
  int touchedIndex = 0;
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
          _dataFutureContent = snapshot.data!.contenido[indexSelectedContent];
          _dataFuture = snapshot.data!;
          return content(watchTheme: watchTheme);
        }
      },
    );
  }

  Widget content({required ThemeProvider watchTheme}) {
    Map<int, Widget> itemsMenu = _dataFuture.contenido!
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
                              listPieChart: _dataFutureContent,
                            ),
                          ),
                        ),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _dataFutureContent.contenido
                                  .map((item) => item.total)
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
              backColor: watchTheme.colors.primary,
              color: watchTheme.colors.background,
              initialValue: indexSelectedContent,
              onValueChanged: (index) {
                setState(() {
                  _dataFutureContent = _dataFuture.contenido![index];
                  indexSelectedContent = index;
                });
              },
              itemsMenu: itemsMenu,
              /*onValueChanged: (i) {
                if (i == 1) {
                  setState(() {
                    _dataFutureContent = _dataFuture.content[0];
                  });
                } else {
                  setState(() {
                    _dataFutureContent = _dataFuture.content[1];
                  });
                }
              },
              itemsMenu: const {
                1: Text('Categoria'),
                2: Text('Producto'),
              },*/
            )
          ],
        ));
  }

  List<PieChartSectionData> showingSectionsList({
    required ThemeProvider watchTheme,
    required WidgetContentDataModel listPieChart,
  }) {
    return listPieChart.contenido!.mapIndexed((i, itemData) {
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
          color: Color((itemData.total * 0xEF927F).toInt()).withOpacity(0.7),
          value: itemData.total,
          title: '${itemData.total}\n${itemData.total.toInt()}',
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

Color generateRandomPastelColor() {
  math.Random random = math.Random();

  // Genera valores RGB aleatorios en el rango apropiado para colores pasteles
  int red = random.nextInt(128) + 128;
  int green = random.nextInt(128) + 128;
  int blue = random.nextInt(128) + 128;

  return Color.fromARGB(255, red, green, blue);
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