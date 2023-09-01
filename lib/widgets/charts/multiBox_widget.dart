// ignore_for_file: non_constant_identifier_names, file_names

import 'package:boss/functions/numbre_function.dart';
import 'package:boss/models/table_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/components/slidingControl_widget.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_multiCard_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiBoxWidget extends StatefulWidget {
  //final BoxesModel boxesData;
  final Future<WidgetDataModel> dataFuture;
  final Future<TableModel> dataFutureDetail;
  final Widget filter;

  const MultiBoxWidget({
    Key? key,
    //required this.boxesData,
    required this.dataFuture,
    required this.dataFutureDetail,
    required this.filter,
  }) : super(key: key);

  @override
  State<MultiBoxWidget> createState() => _MultiBoxWidgetState();
}

class _MultiBoxWidgetState extends State<MultiBoxWidget> {
  int indexSelectedBranch = 1;
  late WidgetContentDataModel SelectedBranch;
  late WidgetDataModel dataBoxes;

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    //Branch SelectedBranch = widget.boxesData.branches[indexSelectedBranch];

    return FutureBuilder<WidgetDataModel>(
        future: widget.dataFuture,
        builder:
            (BuildContext context, AsyncSnapshot<WidgetDataModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SkeletonMultiCardWidget();
          } else if (snapshot.hasError) {
            return Text('Error al cargar los datos: ${snapshot.error}');
          } else if (snapshot.data!.contenido.length > 0) {
            dataBoxes = snapshot.data!;
            SelectedBranch = snapshot.data!.contenido[indexSelectedBranch];
            return CardTemplate(
              filter: widget.filter,
              trailing: SizedBox(),
              data: snapshot.data!,
              dataDetail: widget.dataFutureDetail,
              footer: true,
              header: true,
              child: Column(
                children: contend(
                  watchTheme: watchTheme,
                ),
              ),
            );
          } else {
            return CardTemplate(
              filter: widget.filter,
              trailing: SizedBox(),
              data: snapshot.data!,
              dataDetail: widget.dataFutureDetail,
              footer: true,
              header: true,
              child: Text("No hay Datos"),
            );
          }
        });
  }

  List<Widget> contend({required ThemeProvider watchTheme}) {
    {
      List<Widget> listWidgets = [];
      for (int i = 0; i < SelectedBranch.contenido.length; i++) {
        listWidgets.add(
          itemWidget(watchTheme: watchTheme, box: SelectedBranch.contenido[i]),
        );
        listWidgets.add(
          const SizedBox(
            height: 20,
          ),
        );
        /*if (i == SelectedBranch.content.length - 1) {
        listWidgets.add(
          itemWidget(watchTheme: watchTheme, box: SelectedBranch.content[i]),
        );
      } else {
        listWidgets.add(Row(
          children: [
            Expanded(
              child: itemWidget(
                  watchTheme: watchTheme, box: SelectedBranch.content[i]),
            ),
            Expanded(
              child: itemWidget(
                  watchTheme: watchTheme, box: SelectedBranch.content[i + 1]),
            ),
          ],
        ));
      }*/
      }

      Map<int, Widget> itemsMenu = dataBoxes.contenido
          .mapIndexed((i, branch) => Text(branch.titulo))
          .toList()
          .asMap();

      //itemsMenu[widget.boxesData.branches.length + 1] = Text("total");

      listWidgets.add(
        const SizedBox(
          height: 20,
        ),
      );
      listWidgets.add(
        MySlidingControlWidget(
            backColor: watchTheme.colors.primary,
            color: watchTheme.colors.background,
            initialValue: indexSelectedBranch,
            itemsMenu: itemsMenu,
            onValueChanged: (index) {
              setState(() {
                SelectedBranch = dataBoxes.contenido[index];
                indexSelectedBranch = index;
              });
            }),
      );
      return listWidgets;
    }
  }

  Widget itemWidget({
    required ThemeProvider watchTheme,
    required WidgetContentContentDataModel box,
  }) {
    //double width = (screenWidth - (AppDimensions.spacingMedium * 3)) / 2;
    return Container(
      //width: width,
      decoration: BoxDecoration(
          color: watchTheme.colors.primary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: watchTheme.colors.lightBackground,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSmall)),
                    child: const Padding(
                      padding: EdgeInsets.all(AppDimensions.spacingSmall),
                      child: Icon(
                        Icons.point_of_sale_rounded,
                        size: 25,
                      ),
                    )),
                const SizedBox(width: AppDimensions.spacingSmall),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      box.nombre ?? "",
                      style: TextStyle(
                        fontSize: AppDimensions.fontSizeSmall,
                        color: watchTheme.colors.white,
                      ),
                    ),
                    Text(
                      SelectedBranch.titulo,
                      style: TextStyle(
                          fontSize: AppDimensions.fontSizeXSmall,
                          color: watchTheme.colors.lightPrimary),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  numberFormat(amount: box.total),
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSizeLong,
                  ),
                ),
                Text(
                  " Bs",
                  style: TextStyle(
                      fontSize: AppDimensions.fontSizeSmall,
                      color: watchTheme.colors.lightPrimary,
                      height: 2.8),
                ),
              ],
            ),
            Text(
              box.descripcion ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                  color: watchTheme.colors.lightPrimary),
            ),

            // Spacer(),
          ],
        ),
      ),
    );
  }
}


/*
  List<Widget> rowItems({
    required ThemeProvider watchTheme,
  }) {
    List<Widget> listWidgets = [
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMedium),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                dataBoxes.titulo,
                style: TextStyle(
                  color: watchTheme.colors.white,
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              PopUpInfoWidget(
                iconPopUp: Icons.info,
                color: watchTheme.colors.primary,
                title: dataBoxes.titulo,
                content: Text(
                  dataBoxes.descripcion,
                  style: TextStyle(
                      fontSize: AppDimensions.fontSizeXSmall,
                      color: watchTheme.colors.lightPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    for (int i = 0; i < SelectedBranch.contenido!.length; i = i + 2) {
      listWidgets.add(
        itemWidget(watchTheme: watchTheme, box: SelectedBranch.contenido![i]),
      );
      /*if (i == SelectedBranch.content.length - 1) {
        listWidgets.add(
          itemWidget(watchTheme: watchTheme, box: SelectedBranch.content[i]),
        );
      } else {
        listWidgets.add(Row(
          children: [
            Expanded(
              child: itemWidget(
                  watchTheme: watchTheme, box: SelectedBranch.content[i]),
            ),
            Expanded(
              child: itemWidget(
                  watchTheme: watchTheme, box: SelectedBranch.content[i + 1]),
            ),
          ],
        ));
      }*/
    }

    Map<int, Widget> itemsMenu = dataBoxes.contenido!
        .mapIndexed((i, branch) => Text(branch.titulo))
        .toList()
        .asMap();

    //itemsMenu[widget.boxesData.branches.length + 1] = Text("total");

    listWidgets.add(
      Padding(
        padding: const EdgeInsets.only(
            left: AppDimensions.spacingSmall,
            right: AppDimensions.spacingSmall,
            top: AppDimensions.spacingSmall),
        child: MySlidingControlWidget(
            backColor: watchTheme.colors.background,
            color: watchTheme.colors.primary,
            initialValue: indexSelectedBranch,
            itemsMenu: itemsMenu,
            onValueChanged: (index) {
              setState(() {
                SelectedBranch = dataBoxes.contenido![index];
                indexSelectedBranch = index;
              });
            }),
      ),
    );
    listWidgets.add(myButtonWidgetWidget(
        watchTheme: watchTheme,
        context: context,
        data: dataBoxes,
        dataDetail: widget.dataFutureDetail,
        divider: false));
    listWidgets.add(Divider(
      height: 20,
      color: watchTheme.colors.lightBackground,
    ));
    return listWidgets;
  }


Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      child: Container(
        //width: width,
        decoration: BoxDecoration(
            color: watchTheme.colors.primary,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: watchTheme.colors.lightBackground,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusSmall)),
                      child: const Padding(
                        padding: EdgeInsets.all(AppDimensions.spacingSmall),
                        child: Icon(
                          Icons.point_of_sale_rounded,
                          size: 25,
                        ),
                      )),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        box.nombre ?? "",
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeSmall,
                          color: watchTheme.colors.white,
                        ),
                      ),
                      Text(
                        SelectedBranch.titulo ?? "",
                        style: TextStyle(
                            fontSize: AppDimensions.fontSizeXSmall,
                            color: watchTheme.colors.lightPrimary),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    box.total.toString(),
                    style: const TextStyle(
                      fontSize: AppDimensions.fontSizeLong,
                    ),
                  ),
                  Text(
                    " Bs",
                    style: TextStyle(
                        fontSize: AppDimensions.fontSizeSmall,
                        color: watchTheme.colors.lightPrimary,
                        height: 2.8),
                  ),
                ],
              ),
              Text(
                box.descripcion ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                    fontSize: AppDimensions.fontSizeSmall,
                    color: watchTheme.colors.lightPrimary),
              ),

              // Spacer(),
            ],
          ),
        ),
      ),
    );*/