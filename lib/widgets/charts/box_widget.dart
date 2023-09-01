// ignore_for_file: file_names

import 'package:boss/functions/numbre_function.dart';
import 'package:boss/models/language_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxWidget extends StatefulWidget {
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;
  final Widget filter;

  const BoxWidget({
    Key? key,
    required this.dataFuture,
    required this.dataFutureDetail,
    required this.filter,
  }) : super(key: key);

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  late WidgetDataModel _dataFuture;

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return FutureBuilder<WidgetDataModel>(
      future: widget.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<WidgetDataModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCardWidget();
        } else if (snapshot.hasError) {
          return CardTemplate(
            filter: widget.filter,
            trailing: SizedBox(),
            data: WidgetDataModel(titulo: "", descripcion: "", contenido: []),
            dataDetail: widget.dataFutureDetail,
            footer: true,
            header: true,
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.data is WidgetDataModel) {
          _dataFuture = snapshot.data!;
          return contentSaldo(watchTheme: watchTheme);
        } else {
          return CardTemplate(
            filter: widget.filter,
            trailing: SizedBox(),
            data: WidgetDataModel(titulo: "", descripcion: "", contenido: []),
            dataDetail: widget.dataFutureDetail,
            footer: true,
            header: true,
            child: Text("No hay Datos"),
          );
        }
      },
    );
  }

  Widget contentSaldo({required ThemeProvider watchTheme}) {
    return CardTemplate(
      filter: widget.filter,
      trailing: SizedBox(),
      header: true,
      data: _dataFuture,
      dataDetail: widget.dataFutureDetail,
      footer: true,
      child: Column(
        children: <Widget>[
          Text(
            "Saldo",
            style: TextStyle(
              fontSize: AppDimensions.fontSizeSmall,
              color: watchTheme.colors.lightPrimary,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  numberFormat(
                      amount: ((_dataFuture.contenido[0].contenido[1].total ??
                              0) -
                          (_dataFuture.contenido[0].contenido[0].total ?? 0))),
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold, height: 0),
                ),
                const SizedBox(width: 4),
                const Text(
                  "Bs.",
                  style: TextStyle(
                    height: 3.9,
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: watchTheme.colors.primary,
            surfaceTintColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  transaction("Ingresos",
                      _dataFuture.contenido[0].contenido[1].total ?? 0, true),
                  SizedBox(
                    height: 60,
                    child: VerticalDivider(
                      thickness: 2.5,
                      color: watchTheme.colors.primary,
                    ),
                  ),
                  transaction("Egresos",
                      _dataFuture.contenido[0].contenido[0].total ?? 0, false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transaction(String title, double money, bool entry) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              entry
                  ? const Icon(
                      Icons.arrow_upward_rounded,
                      color: Color(0xff9EDBA2),
                    )
                  : const Icon(
                      Icons.arrow_downward_rounded,
                      color: Color(0xffEF927F),
                    ),
              Text(
                title,
                style: const TextStyle(height: 2.3, color: Color(0xffA7B5BF)),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  numberFormat(amount: money),
                  style: const TextStyle(
                    fontSize: 25,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 2),
                const Text(
                  "Bs.",
                  style: TextStyle(
                    fontSize: 12,
                    height: 2.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
