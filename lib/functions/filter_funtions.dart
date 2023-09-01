import 'package:boss/models/filter_model.dart';
import 'package:boss/models/request_model.dart';
import 'package:intl/intl.dart';

List<RequestVariable> ListFilterDetail(
    {required List<FiltroEspecifico> listFilter}) {
  List<RequestVariable> newlistFilter =
      listFilter.map((filter) => FilterDetail(filter: filter)).toList();

  return newlistFilter;
}

RequestVariable FilterDetail({required FiltroEspecifico filter}) {
  DateTime fecha = DateTime.now();

  switch (filter.valorInicial) {
    case "hoy":
      filter.valorInicial =
          DateFormat('dd/MM/yyyy').format(fecha); // "01/07/2023";
      break;
    case "semana":
      filter.valorInicial = DateFormat('dd/MM/yyyy')
          .format(fecha.subtract(Duration(days: 7))); //"01/06/2023";
      break;
    case "mes":
      filter.valorInicial = DateFormat('dd/MM/yyyy').format(
          DateTime(fecha.year, fecha.month - 1, fecha.day)); //"01/06/2023";
      break;
    case "trimestre":
      filter.valorInicial = DateFormat('dd/MM/yyyy').format(
          DateTime(fecha.year, fecha.month - 3, fecha.day)); //"01/06/2023";
      break;
    case "semestre":
      filter.valorInicial = DateFormat('dd/MM/yyyy').format(
          DateTime(fecha.year, fecha.month - 6, fecha.day)); //"01/10/2022";
      break;
  }

  RequestVariable newFilter =
      RequestVariable(nombre: filter.variable, valor: filter.valorInicial);

  return newFilter;
}
