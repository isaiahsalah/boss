import 'package:boss/models/ExampleModel.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/charts/MyDataTableWidget.dart';
import 'package:boss/widgets/main/MyCardWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ExampleChart extends StatefulWidget {
  const ExampleChart({super.key});

  @override
  State<ExampleChart> createState() => _ExampleChartState();
}

class _ExampleChartState extends State<ExampleChart> {
  ExampleModel? exampleData;
  @override
  void initState() {
    super.initState();
    print("object");
    getExample();
  }

  Future<void> getExample() async {
    final path = "https://rickandmortyapi.com/api/character";
    final response = await Dio().get(path);
    exampleData = ExampleModel.fromJson(response.data);
    setState(() {});
    print(exampleData);
  }

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      title: "title",
      description: "description",
      footer: true,
      widgetContend: SingleChildScrollView(
        child: DataTable(
          columnSpacing: AppDimensions.spacingMedium,
          dividerThickness: 1,
          columns: <DataColumn>[
            titleTable("Nombre"),
            titleTable("Nombre"),
            titleTable("Tipo"),
            titleTable("Lugar"),
          ],
          rows: exampleData?.results
                  ?.take(3)
                  .map(
                    (data) => DataRow(
                      cells: <DataCell>[
                        descriptionTable(data.id.toString()),
                        descriptionTable(data.name),
                        descriptionTable(data.type),
                        descriptionTable(data.location.name),
                      ],
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
