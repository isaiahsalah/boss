import 'package:boss/models/ChartModel.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppResources.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHorizontalBarChartWidget extends StatefulWidget {
  final String title;
  final String description;
  final String chartListTitle;
  final String chartListAltTitle;
  final List<ChartDataModel> chartList;
  final List<ChartDataModel> chartListAlt;
  const MyHorizontalBarChartWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.chartListTitle,
    required this.chartListAltTitle,
    required this.chartList,
    required this.chartListAlt,
  }) : super(key: key);

  @override
  State<MyHorizontalBarChartWidget> createState() =>
      _MyHorizontalBarChartWidgetState();
}

class _MyHorizontalBarChartWidgetState
    extends State<MyHorizontalBarChartWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width < 600
        ? MediaQuery.of(context).size.width
        : 600;
    double height = MediaQuery.of(context).size.height;
    return MyCardWidget(
        title: widget.title,
        description: widget.description,
        footer: true,
        widgetContend: Column(children: listWidget(width)));
  }

  List<Widget> listWidget(double width) {
    List<ChartDataModel> listita = widget.chartList;
    listita.sort((a, b) => b.value.compareTo(a.value));
    return listita
        .map((item) => MyLineBarChartWidget(
              title: item.title,
              quantity: RowSize(item.value, mayorNumber(), width),
            ))
        .take(3)
        .toList();
  }

  double RowSize(double quantity, double maxQuantity, double width) {
    final double newQuantity =
        (width - (AppDimensions.spacingMedium * 4)) / (maxQuantity / quantity);
    return newQuantity;
  }

  double mayorNumber() {
    double numberList1 = widget.chartList.map((item) => item.value).reduce(
        (valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    double numberList2 = widget.chartListAlt.map((item) => item.value).reduce(
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
}

class MyLineBarChartWidget extends StatelessWidget {
  final String title;
  final double quantity;
  const MyLineBarChartWidget({
    Key? key,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.spacingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppDimensions.fontSizeXSmall,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        quantity.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeXSmall,
                        ),
                      ),
                      Text(
                        'Bs',
                        style: TextStyle(
                            fontSize: AppDimensions.fontSizeXSmall,
                            color: watchTheme.colors.lightPrimary),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: watchTheme.colors.lightBackground,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSmall),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: watchTheme.colors.lightPrimary,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusSmall)),
                          height: 8,
                          width: quantity,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
