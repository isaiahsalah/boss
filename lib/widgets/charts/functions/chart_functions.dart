import 'package:boss/models/widgets/widgetData_model.dart';

class ChartFuntions {
  static double maxX(WidgetDataModel listData) {
    double numberList = listData.contenido!
        .map((listDataValues) => listDataValues.contenido!.length)
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente)
        .toDouble();

    return numberList;
  }

  static double minY(WidgetDataModel listData) {
    double numberList = listData.contenido!
        .map((listDataValues) => listDataValues.contenido!
            .map((item) => item.total)
            .reduce((valorActual, valorSiguiente) =>
                valorActual < valorSiguiente ? valorActual : valorSiguiente))
        .reduce((valorActual, valorSiguiente) =>
            valorActual < valorSiguiente ? valorActual : valorSiguiente)
        .toDouble();
    return numberList;
  }

  static double maxY(WidgetDataModel listData) {
    double numberList = listData.contenido!
        .map((listDataValues) => listDataValues.contenido!
            .map((item) => item.total)
            .reduce((valorActual, valorSiguiente) =>
                valorActual > valorSiguiente ? valorActual : valorSiguiente))
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente)
        .toDouble();
    return numberList / 0.85;
  }

  static double intervalY(WidgetDataModel listData) {
    double numberList = listData.contenido!
        .map((listDataValues) => listDataValues.contenido!
            .map((item) => item.total)
            .reduce((valorActual, valorSiguiente) =>
                valorActual > valorSiguiente ? valorActual : valorSiguiente))
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente)
        .toDouble();
    return numberList / 10;
  }

  static double intervalX(WidgetDataModel listData) {
    int numberList = listData.contenido!
        .map((listDataValues) => listDataValues.contenido!.length)
        .reduce((valorActual, valorSiguiente) =>
            valorActual > valorSiguiente ? valorActual : valorSiguiente);
    return numberList / 10.toDouble();
  }
}
