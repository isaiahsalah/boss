import 'package:boss/models/filter_model.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComboFilter extends StatefulWidget {
  final FiltroEspecifico filter;
  final Function comboUpdate;

  const ComboFilter({
    Key? key,
    required this.filter,
    required this.comboUpdate,
  }) : super(key: key);

  @override
  State<ComboFilter> createState() => _ComboFilterState();
}

class _ComboFilterState extends State<ComboFilter> {
  late String _selectedCombo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCombo = widget
        .filter.fuenteDatos![int.parse(widget.filter.valorInicial)].id
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    Widget _showDialog() {
      return DropdownButton<String>(
        value: _selectedCombo,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: TextStyle(color: watchTheme.colors.white),
        underline: Container(
          height: 2,
          color: watchTheme.colors.white,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          print("================================");
          print(value);
          print("================================");

          setState(() {
            widget.comboUpdate(value);
            _selectedCombo = value!;
          });
        },
        items: widget.filter.fuenteDatos!
            .map<DropdownMenuItem<String>>((FuenteDato fuenteDato) {
          String valorcito = fuenteDato.id.toString();

          return DropdownMenuItem<String>(
            value: valorcito,
            child: Text(fuenteDato.nombre),
          );
        }).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.filter.nombre,
          style: TextStyle(
            fontSize: AppDimensions.fontSizeXSmall,
            color: watchTheme.colors.lightPrimary,
          ),
        ),
        _showDialog(),
      ],
    );
  }
}
