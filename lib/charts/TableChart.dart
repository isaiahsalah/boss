// ignore_for_file: file_names

import 'package:boss/models/MinStockModel.dart';
import 'package:boss/widgets/charts/TableWidget.dart';
import 'package:flutter/material.dart';

class TableChart extends StatefulWidget {
  const TableChart({super.key});

  @override
  State<TableChart> createState() => _TableChartState();
}

class _TableChartState extends State<TableChart> {
  MinStockModel? minStockData;
  @override
  void initState() {
    super.initState();
    getExample();
  }

  Future<void> getExample() async {
    /*final path = "https://rickandmortyapi.com/api/character";
    final response = await Dio().get(path);
    exampleData = ExampleModel.fromJson(response.data);*/
    minStockData = MinStockModel(
      company: "company",
      description: "description",
      branch: <Branch>[
        Branch(name: "name", description: "description", items: <Item>[
          Item(
            id: "cc-200",
            name: "Crema hidratante Cerave",
            stock: 70,
            minStock: 60,
          ),
          Item(
            id: "aj-210",
            name: "Diazepam 10 mg",
            stock: 80,
            minStock: 50,
          ),
          Item(
            id: "cn-150",
            name: "Omeprazol 20 mg",
            stock: 45,
            minStock: 25,
          ),
          Item(
            id: "ib-400",
            name: " Ibuprofeno 400 mg",
            stock: 100,
            minStock: 60,
          )
        ])
      ],
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TableWidget(
        title: "Stock Minimo",
        description: "Aquí puede ver los stocks minimos",
        minStockData: minStockData!);
  }
}
