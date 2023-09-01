import 'package:intl/intl.dart';

String numberFormat({required amount}) {
  NumberFormat numberFormat = NumberFormat('#,##0.00',
      'en_US'); // Crea un formato con separador de miles y dos decimales

  String formattedAmount = numberFormat.format(amount);
  return formattedAmount;
}
