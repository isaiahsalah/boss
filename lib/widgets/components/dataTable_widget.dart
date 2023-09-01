import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataTableWidget extends StatelessWidget {
  final TableModel dataTable;

  const DataTableWidget({Key? key, required this.dataTable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return SingleChildScrollView(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: MediaQuery.of(context).size.width -
                (AppDimensions.spacingLong * 4), // Ancho máximo

            child: Theme(
              data: Theme.of(context).copyWith(
                //shadowColor: Colors.transparent,
                cardTheme: CardTheme(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: watchTheme.colors.background,
                ),
              ),
              child: PaginatedDataTable(
                rowsPerPage: 5,
                source: _MyDataTableSource(dataTable.contenido!),
                arrowHeadColor: watchTheme.colors.white,

                /*headingRowHeight: 40,
                dataRowMinHeight: 30,
                //header: dataTableHeader(),
                rowsPerPage: 5,
                source: _MyDataTableSource(dataTable.content!),
                    
                columns:
                    dataTable.content![0].keys.map((key) => titleTable(key)).toList(),
                    */
                //headingTextStyle: const TextStyle(fontSize: 12),
                //dataTextStyle: const TextStyle(fontSize: 5),
                columnSpacing: AppDimensions.spacingLong,
                dataRowMinHeight: 1,
                //dividerThickness: 0,
                columns: dataTable.contenido![0].keys
                    .map((key) => titleTable(key))
                    .toList(),
                /*rows: dataTable.contenido!
                    .take(5)
                    .map(
                      (data) => DataRow(
                          cells: data.values
                              .toList()
                              .map((value) => descriptionTable(value.toString()))
                              .toList()),
                    )
                    .toList(),*/
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow getRow(Map<String, dynamic> data) {
    return DataRow(
      cells: data.keys
          .map((key) => descriptionTable(data[key].toString()))
          .toList(),
    );
  }

  DataCell descriptionTable(String text) {
    return DataCell(
      Text(
        text,
        style: const TextStyle(fontSize: AppDimensions.fontSizeXXSmall),
      ),
    );
  }

  DataColumn titleTable(String title) {
    return DataColumn(
      label: Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.fontSizeXXSmall,
          ),
        ),
      ),
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  // final TableModel _data;

  final List<Map<String, dynamic>> _data;

  _MyDataTableSource(this._data);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
/*
  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }
    return DataTableWidget(
      dataTable: null,
    ).getRow(_data[index]);
  }



  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
    ]);*/

  @override
  DataRow getRow(int index) {
    return DataRow(
        cells: _data[index]
            .values
            .toList()
            .map((value) => DataCell(Text(value.toString())))
            .toList());
  }
}
