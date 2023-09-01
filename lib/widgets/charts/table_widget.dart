// ignore_for_file: file_names

import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/components/dataTable_widget.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  final Future<TableModel> dataFuture;
  final Future<TableModel> dataFutureDetail;

  const TableWidget({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
  }) : super(key: key);

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late TableModel _dataTable;
  /*@override
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
    return FutureBuilder<TableModel>(
      future: widget.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<TableModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los datos');
        } else {
          _dataTable = snapshot.data!;
          return contendWidget();
        }
      },
    );
  }

  Widget contendWidget() {
    return CardTemplate(
        filter: Icon(Icons.abc),
        trailing: SizedBox(),
        header: true,
        data: WidgetDataModel(titulo: "", descripcion: "", contenido: []),
        dataDetail: widget.dataFutureDetail,
        footer: true,
        child: DataTableWidget(dataTable: _dataTable));
  }
}
