// ignore_for_file: non_constant_identifier_names, file_names

import 'package:boss/models/BoxesModel.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyPopUpInfoWidget.dart';
import 'package:boss/widgets/components/MySlidingControlWidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResumeWidget extends StatefulWidget {
  final BoxesModel boxesData;
  final String title;
  final String description;

  const ResumeWidget({
    Key? key,
    required this.boxesData,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<ResumeWidget> createState() => _ResumeWidgetState();
}

class _ResumeWidgetState extends State<ResumeWidget> {
  int indexSelectedBranch = 1;
  late Branch SelectedBranch;

  @override
  void initState() {
    super.initState();
    // Inicializar los datos del gráfico de dona con los datos iniciales
    SelectedBranch = widget.boxesData.branches[indexSelectedBranch];
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    double screenWidth = MediaQuery.of(context).size.width;

    //Branch SelectedBranch = widget.boxesData.branches[indexSelectedBranch];

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingSmall, vertical: 0),
      child: Column(
        children: rowItems(
          watchTheme: watchTheme,
          screenWidth: screenWidth,
        ),
      ),
    );
  }

  List<Widget> rowItems({
    required ThemeProvider watchTheme,
    required double screenWidth,
  }) {
    List<Widget> listWidgets = [
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMedium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                color: watchTheme.colors.white,
                fontSize: AppDimensions.fontSizeSmall,
              ),
            ),
            PopUpInfoWidget(
              iconPopUp: Icons.info,
              title: widget.title,
              description: widget.description,
            ),
          ],
        ),
      )
    ];
    for (int i = 0; i < SelectedBranch.boxes.length; i = i + 2) {
      if (i == SelectedBranch.boxes.length - 1) {
        listWidgets.add(
          itemWidget(
              watchTheme: watchTheme,
              screenWidth: screenWidth * 2,
              box: SelectedBranch.boxes[i]),
        );
      } else {
        listWidgets.add(Row(
          children: [
            itemWidget(
                watchTheme: watchTheme,
                screenWidth: screenWidth,
                box: SelectedBranch.boxes[i]),
            itemWidget(
                watchTheme: watchTheme,
                screenWidth: screenWidth,
                box: SelectedBranch.boxes[i + 1]),
          ],
        ));
      }
    }

    Map<int, Widget> itemsMenu = widget.boxesData.branches
        .mapIndexed((i, branch) => Text(branch.title))
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
            backColor: watchTheme.colors.primary,
            color: watchTheme.colors.lightBackground,
            initialValue: indexSelectedBranch,
            itemsMenu: itemsMenu,
            onValueChanged: (index) {
              setState(() {
                SelectedBranch = widget.boxesData.branches[index];
                indexSelectedBranch = index;
              });
            }),
      ),
    );
    listWidgets.add(Divider(
      height: 20,
      color: watchTheme.colors.lightBackground,
    ));
    return listWidgets;
  }

  Widget itemWidget({
    required ThemeProvider watchTheme,
    required double screenWidth,
    required Box box,
  }) {
    double width = (screenWidth - (AppDimensions.spacingMedium * 3)) / 2;
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: watchTheme.colors.primary,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: watchTheme.colors.lightBackground,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusSmall)),
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
                          box.title,
                          style: TextStyle(
                              fontSize: AppDimensions.fontSizeSmall,
                              color: watchTheme.colors.white),
                        ),
                        Text(
                          box.branch,
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
                      box.value.toString(),
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
                  box.description,
                  style: TextStyle(
                      fontSize: AppDimensions.fontSizeSmall,
                      color: watchTheme.colors.lightPrimary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
