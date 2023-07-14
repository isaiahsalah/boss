import 'package:boss/widgets/charts/SaldoWidget.dart';
import 'package:flutter/material.dart';

class ExampleBalanceChart extends StatelessWidget {
  const ExampleBalanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyBalanceWidget(
      title: "Balance General",
      description:
          "En este Widget, puede ver todos los ingresos y egresos de su organización",
      entryMoney: 5852,
      exitMoney: -2456,
    );
  }
}
