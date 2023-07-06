import 'package:boss/widgets/charts/MySaldoWidget.dart';
import 'package:flutter/material.dart';

class ExampleBalanceChart extends StatelessWidget {
  const ExampleBalanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyBalanceWidget(
      title: "",
      description: "",
      entryMoney: 5000,
      exitMoney: 1000,
    );
  }
}
