// ignore_for_file: file_names

import 'package:boss/models/MinStockModel.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/charts/MyDataTableWidget.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  final String title;
  final String description;
  final MinStockModel minStockData;

  const TableWidget({
    Key? key,
    required this.minStockData,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  /*MinStockModel? minStockData;
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
          Item(id: "id", name: "name", stock: 45, minStock: 21)
        ])
      ],
    );
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      header: true,
      title: widget.title,
      description: widget.description,
      footer: false,
      widgetContend: SingleChildScrollView(
        child: Center(
          child: DataTable(
            headingTextStyle: const TextStyle(fontSize: 12),
            dataTextStyle: const TextStyle(fontSize: 5),
            columnSpacing: AppDimensions.spacingLong,
            dataRowMinHeight: 1,
            dividerThickness: 0,
            columns: <DataColumn>[
              //DataColumn(label: label),
              titleTable("Código"),
              titleTable("Nombre"),
              titleTable("Cantidad"),
              titleTable("Mínimo"),
            ],
            rows: widget.minStockData.branch[0].items
                .take(5)
                .map(
                  (data) => DataRow(
                    cells: <DataCell>[
                      descriptionTable(data.id),
                      descriptionTable(data.name),
                      descriptionTable(data.stock.toString()),
                      descriptionTable(data.minStock.toString()),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
