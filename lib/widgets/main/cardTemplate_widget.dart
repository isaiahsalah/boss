// ignore_for_file: file_names

import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:boss/models/filter_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/button_widget.dart';
import 'package:boss/widgets/components/dataTable_widget.dart';
import 'package:boss/widgets/components/infoDialog_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardTemplate extends StatefulWidget {
  final WidgetDataModel data;
  final Future<TableModel> dataDetail;
  final bool footer;
  final bool header;
  final Widget trailing;

  final Widget child;
  final Widget filter;

  const CardTemplate({
    Key? key,
    required this.data,
    required this.dataDetail,
    required this.footer,
    required this.header,
    required this.child,
    required this.trailing,
    required this.filter,
  }) : super(key: key);

  @override
  State<CardTemplate> createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplate> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return Center(
      child: FadeIn(
        duration: const Duration(milliseconds: 800),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingMedium,
                vertical: 0,
              ),
              child: Column(
                children: [
                  Card(
                    surfaceTintColor: Colors.transparent,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingMedium,
                        vertical: AppDimensions.spacingSmall,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          widget.header
                              ? myTitleWidgetWidget(watchTheme: watchTheme)
                              : const SizedBox(),
                          Divider(
                            height: 20,
                            color: watchTheme.colors.lightBackground,
                          ),
                          const SizedBox(height: AppDimensions.spacingSmall),
                          widget.child,
                          const SizedBox(height: AppDimensions.spacingSmall),
                          widget.footer
                              ? myButtonWidgetWidget(
                                  watchTheme: watchTheme,
                                  context: context,
                                  data: widget.data,
                                  dataDetail: widget.dataDetail,
                                  divider: true)
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: watchTheme.colors.lightBackground,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myTitleWidgetWidget({required ThemeProvider watchTheme}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.spacingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.data.titulo,
            style: TextStyle(
              color: watchTheme.colors.white,
              fontSize: AppDimensions.fontSizeSmall,
            ),
          ),
          widget.trailing
        ],
      ),
    );
  }

  Widget myButtonWidgetWidget(
      {required ThemeProvider watchTheme,
      required BuildContext context,
      required WidgetDataModel data,
      required Future<TableModel> dataDetail,
      required bool divider}) {
    return Column(
      children: [
        divider
            ? Divider(
                height: 0,
                color: watchTheme.colors.lightBackground,
              )
            : SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            PopUpInfoWidget(
              iconPopUp: Icons.info,
              color: watchTheme.colors.white,
              title: data.titulo,
              content: Text(
                data.descripcion,
                style: TextStyle(
                    fontSize: AppDimensions.fontSizeXSmall,
                    color: watchTheme.colors.lightPrimary),
              ),
            ),
            IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  titlePadding: const EdgeInsets.only(
                    right: AppDimensions.spacingMedium,
                    left: AppDimensions.spacingMedium,
                    top: AppDimensions.spacingMedium,
                    bottom: AppDimensions.spacingSmall,
                  ),
                  contentPadding: const EdgeInsets.only(
                    right: AppDimensions.spacingSmall,
                    left: AppDimensions.spacingSmall,
                    bottom: AppDimensions.spacingSmall,
                  ),
                  actionsPadding:
                      const EdgeInsets.all(AppDimensions.spacingSmall),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions
                        .radiusSmall), // Modifica el radio de borde aquí
                  ),
                  backgroundColor: watchTheme.colors.background,
                  surfaceTintColor: Colors.transparent,
                  contentTextStyle: const TextStyle(),
                  titleTextStyle: const TextStyle(),
                  title: Text(
                    data.titulo,
                    style:
                        const TextStyle(fontSize: AppDimensions.fontSizeSmall),
                  ),
                  content: FutureBuilder<TableModel>(
                    future: dataDetail,
                    builder: (BuildContext context,
                        AsyncSnapshot<TableModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SkeletonCardWidget();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error al cargar los datos: ${snapshot.error}');
                      } else {
                        return Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTableWidget(dataTable: snapshot.data!),
                          ),
                        );
                      }
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: Text(
                        'OK',
                        style: TextStyle(color: watchTheme.colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              icon: Icon(Icons.assignment),
            ),
            widget.filter
          ],
        ),
      ],
    );
  }
}
/*PopUpInfoWidget(
            iconPopUp: Icons.info,
            color: watchTheme.colors.primary,
            title: widget.data.titulo,
            content: Text(
              widget.data.descripcion,
              style: TextStyle(
                  fontSize: AppDimensions.fontSizeXSmall,
                  color: watchTheme.colors.lightPrimary),
            ),
          ),*/




/*GestureDetector(
            /*style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
              ),*/
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingSmall),
              child: Text(
                "Ver Más",
                style: TextStyle(
                  color: watchTheme.colors.white,
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
            ),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                titlePadding: const EdgeInsets.only(
                  right: AppDimensions.spacingMedium,
                  left: AppDimensions.spacingMedium,
                  top: AppDimensions.spacingMedium,
                  bottom: AppDimensions.spacingSmall,
                ),
                contentPadding: const EdgeInsets.only(
                  right: AppDimensions.spacingSmall,
                  left: AppDimensions.spacingSmall,
                  bottom: AppDimensions.spacingSmall,
                ),
                actionsPadding:
                    const EdgeInsets.all(AppDimensions.spacingSmall),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions
                      .radiusSmall), // Modifica el radio de borde aquí
                ),
                backgroundColor: watchTheme.colors.background,
                surfaceTintColor: Colors.transparent,
                contentTextStyle: const TextStyle(),
                titleTextStyle: const TextStyle(),
                title: Text(
                  data.titulo,
                  style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
                ),
                content: FutureBuilder<TableModel>(
                  future: dataDetail,
                  builder: (BuildContext context,
                      AsyncSnapshot<TableModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SkeletonCardWidget();
                    } else if (snapshot.hasError) {
                      //print("ERRORRRRRR:" + snapshot.error.toString());
                      return  Text('Error al cargar los datos: ${snapshot.error}');
                    } else {
                      return Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTableWidget(dataTable: snapshot.data!),
                        ),
                      );
                    }
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      'OK',
                      style: TextStyle(color: watchTheme.colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )*/