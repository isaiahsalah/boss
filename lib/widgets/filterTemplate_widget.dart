import 'package:boss/models/filter_model.dart';
import 'package:boss/models/widgets/widgetData_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/charts/filter_widget.dart';
import 'package:boss/widgets/filters/combo_filter.dart';
import 'package:boss/widgets/filters/dateTime_filter.dart';
import 'package:boss/widgets/main/appBar_widget.dart';
import 'package:boss/widgets/main/cardTemplate_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
class FilterTemplateWidget extends StatefulWidget {
  final FilterModel filterModel;
  const FilterTemplateWidget({
    Key? key,
    required this.filterModel,
  }) : super(key: key);

  @override
  State<FilterTemplateWidget> createState() => _FilterTemplateWidgetState();
}

class _FilterTemplateWidgetState extends State<FilterTemplateWidget> {
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime =
  }

  Widget filterShow2({
    required FiltroEspecifico filter,
    required BuildContext context,
  }) {
    switch (filter.tipo) {
      case "FECHA":
        return DateTimeFilter2(
          context: context,
          title: filter.nombre,
          dateTime: DateFormat('dd/MM/yyyy').parse(filter.valorInicial),
          dateTimeChange: (DateTime newDate) {
            setState(() {
              filter.valorInicial = DateFormat('dd/MM/yyyy').format(newDate);
            });
            //dateTimeChange(newDate);
            /* setState(() {
            filterDate = newDate;
            filter.valorInicial = DateFormat('dd/MM/yyyy').format(newDate);
          });*/
          },
        );

      default:
        return Text("no-data");
    }
  }

  Widget DateTimeFilter2({
    required String title,
    required DateTime dateTime,
    required Function dateTimeChange,
    required BuildContext context,
  }) {
    //DateTime _selectedDate = dateTime;
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions.fontSizeXSmall,
            color: watchTheme.colors.lightPrimary,
          ),
        ),
        CupertinoButton(
          borderRadius: BorderRadius.zero,
          minSize: AppDimensions.fontSizeSmall,
          padding: EdgeInsets.zero,
          color: Colors.transparent,
          child: Text(
            '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}',
            style: const TextStyle(
              fontSize: AppDimensions.fontSizeSmall,
            ),
          ),
          onPressed: () => _showDialog2(
              //read: readDateTime,

              child: CupertinoDatePicker(
            dateOrder: DatePickerDateOrder.dmy,
            initialDateTime: dateTime,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: false,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                dateTimeChange(newDate);
              });
              //_selectedDate = newDate;
            },
          )),
        ),
      ],
    );
  }

  void _showDialog2({required Widget child}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    void onPressedCancel() => {Navigator.pop(context)};
    void onPressedConfirm() => {Navigator.pop(context)};
    return IconButton(
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
          actionsPadding: const EdgeInsets.all(AppDimensions.spacingSmall),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall), // Modifica el radio de borde aquí
          ),
          backgroundColor: watchTheme.colors.background,
          surfaceTintColor: Colors.transparent,
          contentTextStyle: const TextStyle(),
          titleTextStyle: const TextStyle(),
          title: Text(
            "Filtro",
            style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.filterModel.filtros
                .map((filter) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: filterShow2(filter: filter, context: context),
                    ))
                .toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                'Cancelar',
                style: TextStyle(color: watchTheme.colors.white),
              ),
            ),
            TextButton(
              onPressed: () => {
                setState(() {
                  //_savedText = _textEditingController.text;
                }),
                //Navigator.pop(context, 'OK')
              },
              child: Text(
                'Filtrar',
                style: TextStyle(color: watchTheme.colors.white),
              ),
            ),
          ],
        ),
      ),
      icon: Icon(Icons.filter_list_outlined),
    );
  }
}
*/
/////////////////////////////////////////////////////////////////////////////////
/*
void _showDialog({required Widget child, required BuildContext context}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}
/*
Widget DateTimeFilter({
  required String title,
  required DateTime dateTime,
  required Function dateTimeChange,
  required BuildContext context,
}) {
  //DateTime _selectedDate = dateTime;
  ThemeProvider watchTheme = context.watch<ThemeProvider>();

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: AppDimensions.fontSizeXSmall,
          color: watchTheme.colors.lightPrimary,
        ),
      ),
      CupertinoButton(
        borderRadius: BorderRadius.zero,
        minSize: AppDimensions.fontSizeSmall,
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        child: Text(
          '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}',
          style: const TextStyle(
            fontSize: AppDimensions.fontSizeSmall,
          ),
        ),
        onPressed: () => _showDialog(
            context: context,
            //read: readDateTime,

            child: CupertinoDatePicker(
              dateOrder: DatePickerDateOrder.dmy,
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              showDayOfWeek: false,
              onDateTimeChanged: (DateTime newDate) {
                //_selectedDate = newDate;
                dateTimeChange(newDate);
              },
            )),
      ),
    ],
  );
}*/

Widget filterShow({
  required FiltroEspecifico filter,
  required BuildContext context,
  required Function setState,
}) {
  switch (filter.tipo) {
    case "FECHA":
      return DateTimeFilter(
        title: filter.nombre,
        dateTime: DateFormat('dd/MM/yyyy').parse(filter.valorInicial),
        dateTimeUpdate: (DateTime newDate) {
          setState(() {
            filter.valorInicial = DateFormat('dd/MM/yyyy').format(newDate);
          });
        },
      );
    /*return DateTimeFilter(
        context: context,
        title: filter.nombre,
        dateTime: filterDate,
        dateTimeChange: (DateTime newDate) {
          filterDate = newDate;
          filter.valorInicial = DateFormat('dd/MM/yyyy').format(newDate);
          //dateTimeChange(newDate);
          /* setState(() {
            filterDate = newDate;
            filter.valorInicial = DateFormat('dd/MM/yyyy').format(newDate);
          });*/
        },
      );*/

    default:
      return Text("no-data");
  }
}*/

////////////////////////////////////////////////////////////////////////////////

Widget FilterTemplate({
  required BuildContext context,
  required Function setState,
  required ThemeProvider watchTheme,
  required FilterModel filterModel,
}) {
  FilterModel filterModelBackUp = filterModel;

  Future savedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(filterModel.id.toString(), filterModelToJson(filterModel));
  }

  Widget filterShow({
    required FiltroEspecifico filter,
    required BuildContext context,
    required Function setState,
  }) {
    switch (filter.tipo) {
      case "FECHA":
        return DateTimeFilter(
          title: filter.nombre,
          dateTime: DateFormat('dd/MM/yyyy').parse(filter.valorInicial),
          dateTimeUpdate: (DateTime newDate) {
            filter.valorInicial = DateFormat('dd/MM/yyyy').format(newDate);
          },
        );
      case "COMBO":
        return ComboFilter(
          filter: filter,
          comboUpdate: (index) {
            filter.valorInicial = index;
          },
        );
      default:
        return Text("no-data");
    }
  }

  return IconButton(
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
        actionsPadding: const EdgeInsets.all(AppDimensions.spacingSmall),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall), // Modifica el radio de borde aquí
        ),
        backgroundColor: watchTheme.colors.background,
        surfaceTintColor: Colors.transparent,
        contentTextStyle: const TextStyle(),
        titleTextStyle: const TextStyle(),
        title: Text(
          "Filtro",
          style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: filterModel.filtros
              .map((filter) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: filterShow(
                        filter: filter, context: context, setState: setState),
                  ))
              .toList(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'Cancelar',
              style: TextStyle(color: watchTheme.colors.white),
            ),
          ),
          TextButton(
            onPressed: () => {
              setState(() {
                //_savedText = _textEditingController.text;
                savedPref();
              }),
              Navigator.pop(context, 'OK')
            },
            child: Text(
              'Filtrar',
              style: TextStyle(color: watchTheme.colors.white),
            ),
          ),
        ],
      ),
    ),
    icon: Icon(Icons.filter_list_outlined),
  );
}







/*
class FilterTemplate extends StatefulWidget {
  final FilterModel filter;
  const FilterTemplate({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  State<FilterTemplate> createState() => _FilterTemplateState();
}

class _FilterTemplateState extends State<FilterTemplate> {
  late FilterModel _filterModel = widget.filter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFilter();
  }

  _loadFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _filterModel = filterModelFromJson(
        prefs.getString(_filterModel.id.toString()) ??
            filterModelToJson(widget.filter));
    //print(_filterModel.id);

    setState(() {
      //_savedText = _textEditingController.text;
    });
  }

  _saveFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        _filterModel.id.toString(), filterModelToJson(_filterModel));
    setState(() {
      //_savedText = _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

/*
   dataFuture = getWidgetBox(
      token: watchUser.user!.token,
      context: context,
      body: requestModelToJson(RequestModel(
        id: widgetData.id,
        tipo: widgetData.params,
        variables: ListFilterDetail(listFilter: filters),
      )));
*/

    return IconButton(
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
          actionsPadding: const EdgeInsets.all(AppDimensions.spacingSmall),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall), // Modifica el radio de borde aquí
          ),
          backgroundColor: watchTheme.colors.background,
          surfaceTintColor: Colors.transparent,
          contentTextStyle: const TextStyle(),
          titleTextStyle: const TextStyle(),
          title: Text(
            "Filtro",
            style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _filterModel.filtros
                .map((filter) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: filterShow(filter),
                    ))
                .toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                'Cancelar',
                style: TextStyle(color: watchTheme.colors.white),
              ),
            ),
            TextButton(
              onPressed: () => {
                setState(() {
                  //_savedText = _textEditingController.text;
                }),
                Navigator.pop(context, 'OK')
              },
              child: Text(
                'Filtrar',
                style: TextStyle(color: watchTheme.colors.white),
              ),
            ),
          ],
        ),
      ),
      icon: Icon(Icons.filter_list_outlined),
    );
  }
}
*/



























/*
Widget filterTemplate(
    {required WidgetModel widgetData,
    required UserProvider watchUser,
    required BuildContext context,
    required ThemeProvider watchTheme,
    required Future<WidgetDataModel> dataFuture,
    required List<FiltroEspecifico> filters}) {
  dataFuture = getWidgetBox(
      token: watchUser.user!.token,
      context: context,
      body: requestModelToJson(RequestModel(
        id: widgetData.id,
        tipo: widgetData.params,
        variables: ListFilterDetail(listFilter: filters),
      )));
  return IconButton(
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
        actionsPadding: const EdgeInsets.all(AppDimensions.spacingSmall),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall), // Modifica el radio de borde aquí
        ),
        backgroundColor: watchTheme.colors.background,
        surfaceTintColor: Colors.transparent,
        contentTextStyle: const TextStyle(),
        titleTextStyle: const TextStyle(),
        title: Text(
          "Filtro",
          style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: filters.map((filter) => Text(filter.nombre)).toList(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'Cancelar',
              style: TextStyle(color: watchTheme.colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'Filtrar',
              style: TextStyle(color: watchTheme.colors.white),
            ),
          ),
        ],
      ),
    ),
    icon: Icon(Icons.filter_list_outlined),
  );

  
}
*/



/*
Widget DateFilter({
    required DateTime dateTime,
    required Function dateTimeChange,
    required ThemeProvider watchTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fecha de inicio",
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            CupertinoButton(
              borderRadius: BorderRadius.zero,
              minSize: AppDimensions.fontSizeSmall,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              child: Text(
                '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${datetimeInit.year}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                read: readDateTime,
                child: CupertinoDatePicker(
                  initialDateTime: datetimeInit,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    if (newDate.isBefore(datetimeEnd)) {
                      datetimechange(newDate);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Hora de inicio",
              style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary,
              ),
            ),
            CupertinoButton(
              borderRadius: BorderRadius.zero,
              minSize: AppDimensions.fontSizeSmall,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              child: Text(
                '${datetimeInit.hour.toString().padLeft(2, '0')}:${datetimeInit.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () => _showDialog(
                read: readDateTime,
                child: CupertinoDatePicker(
                  initialDateTime: datetimeInit,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  // This is called when the user changes the time.
                  onDateTimeChanged: (DateTime newTime) {
                    if (newTime.isBefore(datetimeEnd)) {
                      datetimechange(newTime);
                    } else {
                      datetimechange(datetimeInit);
                    }
                  },
                ),
              ),
              // In this example, the time value is formatted manually.
              // You can use the intl package to format the value based on
              // the user's locale settings.
            ),
          ],
        ),
      ],
    );
  }

 */ 