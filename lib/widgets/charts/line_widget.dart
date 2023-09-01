// ignore_for_file: file_names

import 'dart:math';

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

class LineWidget extends StatefulWidget {
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;
  final Widget filter;

  const LineWidget({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
    required this.filter,
  }) : super(key: key);

  @override
  State<LineWidget> createState() => _LineWidgetState();
}

class _LineWidgetState extends State<LineWidget> {
  bool showAvg = false;
  late WidgetDataModel _dataFuture;

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return FutureBuilder<WidgetDataModel>(
      future: widget.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<WidgetDataModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return CardTemplate(
            filter: widget.filter,
            trailing: SizedBox(),
            data: WidgetDataModel(titulo: "", descripcion: "", contenido: []),
            dataDetail: widget.dataFutureDetail,
            footer: false,
            header: true,
            child: Text(snapshot.error.toString()),
          );
          ;
        } else if (snapshot.data!.contenido.length > 0) {
          try {
            _dataFuture = snapshot.data!;
            return content(watchTheme: watchTheme);
          } catch (Exception) {
            return CardTemplate(
              filter: widget.filter,
              trailing: SizedBox(),
              data: WidgetDataModel(
                  titulo: snapshot.data!.titulo,
                  descripcion: snapshot.data!.descripcion,
                  contenido: []),
              dataDetail: widget.dataFutureDetail,
              footer: true,
              header: true,
              child: Text(Exception.toString()),
            );
          }
        } else {
          return CardTemplate(
            filter: widget.filter,
            trailing: SizedBox(),
            data: WidgetDataModel(
                titulo: snapshot.data!.titulo,
                descripcion: snapshot.data!.descripcion,
                contenido: []),
            dataDetail: widget.dataFutureDetail,
            footer: true,
            header: true,
            child: Text("No hay Datos"),
          );
        }
      },
    );
  }

  Widget content({required ThemeProvider watchTheme}) {
    /*
    List<Color> gradientColors = [
      watchTheme.colors.green,
      watchTheme.colors.lightPrimary,
    ];

    List<Color> gradientColorsAlt = [
      watchTheme.colors.active,
      watchTheme.colors.lightPrimary,
    ];*/
    return CardTemplate(
      filter: widget.filter,
      trailing: SizedBox(
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
            'AVG',
            style: TextStyle(
              fontSize: AppDimensions.fontSizeXXSmall,
              color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
            ),
          ),
        ),
      ),
      header: true,
      data: _dataFuture,
      dataDetail: widget.dataFutureDetail,
      footer: true,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                height: 260,
                child: LineChart(
                  showAvg
                      ? avgData(
                          watchTheme: watchTheme,
                        )
                      : mainData(
                          watchTheme: watchTheme,
                        ),
                ),
              ),
            ],
          ),
          //const SizedBox(height: AppDimensions.spacingSmall),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: _dataFuture.contenido!.mapIndexed(
                    (i, item) {
                      return typeChartName(
                        color: ListColor.colors[i]
                            .withOpacity(item.estado ? 1 : 0.2),
                        item: item,
                        watchTheme: watchTheme,
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget typeChartName({
    required Color color,
    required WidgetContentDataModel item,
    required ThemeProvider watchTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingSmall / 2),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            for (var element in _dataFuture.contenido) {
              element.estado = false;
            }
            item.estado = true;
          });
        },
        onTap: () {
          setState(() {
            item.estado = !item.estado;
            if (_dataFuture.contenido
                .every((elemento) => elemento.estado == false)) {
              item.estado = !item.estado;
            }
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
              item.titulo, //KevinCrespo
              style: TextStyle(
                  fontSize: AppDimensions.fontSizeXSmall,
                  color: watchTheme.colors.lightPrimary),
            ),
          ],
        ),
      ),
    );
  }

  WidgetContentDataModel devolverItemLargo(WidgetDataModel _dataFuture) {
    return _dataFuture.contenido!
        .where((elemento) => elemento.estado)
        .reduce((a, b) => a.contenido.length > b.contenido.length ? a : b);
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

    WidgetContentDataModel listaMasLarga = devolverItemLargo(_dataFuture);

    String text = listaMasLarga.contenido![value.toInt()].posicion ?? "";
    //'${_dataFuture.contenido![0].contenido![value.toInt()].datetime!.day}/${_dataFuture.content![0].content![value.toInt()].datetime!.month}';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -1,
      child: Container(
        // color: Colors.amber,
        width: 100, //50, KevinCrespo
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Text(text, style: style)),
      ),
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
    double numberList = _dataFuture.contenido!
        .map((listDataValues) => listDataValues.contenido!
            .map((item) => item.total)
            .reduce((valorActual, valorSiguiente) =>
                valorActual < valorSiguiente ? valorActual : valorSiguiente))
        .reduce((valorActual, valorSiguiente) =>
            valorActual < valorSiguiente ? valorActual : valorSiguiente)
        .toDouble();

    return numberList;
  }

  double maxX() {
    int numberList = _dataFuture.contenido!
        .map((listDataValues) => listDataValues.contenido!.length)
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);

    return numberList - 1.toDouble();
  }

  double intervalY() {
    double numberList = _dataFuture.contenido!
        .map((listDataValues) => listDataValues.contenido!
            .map((item) => item.total)
            .reduce((valorActual, valorSiguiente) =>
                valorActual > valorSiguiente ? valorActual : valorSiguiente))
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente)
        .toDouble();

    return numberList / 10;
  }

  double intervalX() {
    int numberList = _dataFuture.contenido!
        .map((listDataValues) => listDataValues.contenido!.length)
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);

    return numberList / 10.toDouble();
  }

  String reducirCantidad(int cantidad) {
    if (cantidad >= 1000000000 || cantidad <= -1000000000) {
      double cantidadReducida = cantidad / 1000000000;
      String sufijo = 'B';
      return '${cantidadReducida.toStringAsFixed(1)}$sufijo';
    } else if (cantidad >= 1000000 || cantidad <= -1000000) {
      double cantidadReducida = cantidad / 1000000;
      String sufijo = 'M';
      return '${cantidadReducida.toStringAsFixed(1)}$sufijo';
    } else if (cantidad >= 1000 || cantidad <= -1000) {
      double cantidadReducida = cantidad / 1000;
      String sufijo = 'K';
      return '${cantidadReducida.toStringAsFixed(1)}$sufijo';
    } else {
      return cantidad.toString();
    }
  }

  WidgetContentDataModel calculateMean(WidgetDataModel listOfLists) {
    WidgetContentDataModel means =
        WidgetContentDataModel(titulo: "", descripcion: "", contenido: []);
    WidgetContentDataModel itemLargo = devolverItemLargo(listOfLists);

    for (var i = 0; i < itemLargo.contenido.length; i++) {
      String posicion = "";

      double sum = 0;
      int count = 0;

      for (var item in listOfLists.contenido) {
        if (item.estado && item.contenido[i] != null) {
          //print(object);
          posicion = item.contenido[i].posicion!;

          //if(listOfLists.contenido[j] ){}
          sum += item.contenido[i].total;
          count++;
        } else {}
      }

      WidgetContentContentDataModel mean = WidgetContentContentDataModel(
        nombre: "",
        posicion: posicion,
        total: (sum ~/ (count == 0 ? 1 : count)).toDouble(),
      );
      means.contenido.add(mean);
    }

    return means;
  }

  WidgetContentDataModel avgList() {
    WidgetContentDataModel avg = calculateMean(_dataFuture);
    return avg;
  }

  LineChartData mainData({
    required ThemeProvider watchTheme,
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
            reservedSize: 70,
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
            reservedSize: 45,
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
      maxY: ChartFuntions.maxY(_dataFuture),
      lineBarsData:

          //Aqui entran los datos

          _dataFuture.contenido
              .mapIndexed(
                (i, listDataValue) =>
                    //listDataValue.estado==true ??
                    LineChartBarData(
                  spots: listDataValue.contenido
                      .mapIndexed(
                        (i, item) => FlSpot(i.toDouble(), item.total),
                      )
                      .toList(),
                  isCurved: false,
                  gradient: LinearGradient(
                    colors: [
                      ListColor.colors[i]
                          .withOpacity(listDataValue.estado ? 1 : 0),
                      ListColor.colors[i]
                          .withOpacity(listDataValue.estado ? 1 : 0),
                    ],
                  ),
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(colors: [
                      watchTheme.colors.lightPrimary
                          .withOpacity(listDataValue.estado ? 0.25 : 0),
                      ListColor.colors[i]
                          .withOpacity(listDataValue.estado ? 0.25 : 0),
                    ]),
                  ),
                ),
              )
              .toList(),
    );
  }

  LineChartData avgData({required ThemeProvider watchTheme}) {
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
            reservedSize: 70,
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
            reservedSize: 45,
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
      maxY: ChartFuntions.maxY(_dataFuture),
      lineBarsData: [
        LineChartBarData(
          spots: avgList()
              .contenido
              .mapIndexed((i, item) => FlSpot(i.toDouble(), item.total))
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
