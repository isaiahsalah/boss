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

class MyMultiPieChartWidget extends StatefulWidget {
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;

  const MyMultiPieChartWidget({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
  }) : super(key: key);
  @override
  State<MyMultiPieChartWidget> createState() => _MyMultiPieChartWidgetState();
}

class _MyMultiPieChartWidgetState extends State<MyMultiPieChartWidget> {
  int touchedIndex = -1;
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
          _dataFuture = snapshot.data!;
          _dataFutureContent = snapshot.data!.contenido![indexSelectedContent];

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
            pieChart(watchTheme: watchTheme),
            MySlidingControlWidget(
              backColor: watchTheme.colors.primary,
              color: watchTheme.colors.background,
              onValueChanged: (index) {
                setState(() {
                  _dataFutureContent = _dataFuture.contenido![index];
                  indexSelectedContent = index;
                });
              },
              itemsMenu: itemsMenu,
              initialValue: indexSelectedContent,
            )
          ],
        ));
  }

  Widget pieChart({required ThemeProvider watchTheme}) {
    double listDataTotal = 0;

    for (int i = 0; i < _dataFutureContent.contenido!.length; i++) {
      listDataTotal += _dataFutureContent.contenido![i].total;
    }

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppDimensions.spacingMedium),
      child: Column(
          children: _dataFutureContent.contenido!
              .map(
                (item) => Row(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
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
                                        pieTouchResponse.touchedSection ==
                                            null) {
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
                              centerSpaceRadius:
                                  AppDimensions.spacingSmall * 4.5,
                              sections: showingSectionsList(
                                watchTheme: watchTheme,
                                listPieChart: [
                                  WidgetContentContentDataModel(
                                    nombre: "title",
                                    total: listDataTotal,
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
                                    '${((item.total / listDataTotal) * 100).toInt().toString()}%'),
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
                                  item.total.toInt().toString(),
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
                              item.nombre ?? "",
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
              .toList()),
    );
  }

  List<PieChartSectionData> showingSectionsList({
    required ThemeProvider watchTheme,
    required List<WidgetContentContentDataModel> listPieChart,
    //required ChartValueModel itemDataChart,
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
              ? watchTheme.colors.primary
              : watchTheme.colors.lightPrimary,
          value: itemData.total,
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