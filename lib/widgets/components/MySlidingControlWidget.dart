import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySlidingControlWidget extends StatelessWidget {
  final int initialValue;
  final Color backColor;
  final Color color;

  final Map<int, Widget> itemsMenu;
  final Function(int i) onValueChanged;
  const MySlidingControlWidget({
    Key? key,
    required this.initialValue,
    required this.itemsMenu,
    required this.backColor,
    required this.color,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return CustomSlidingSegmentedControl<int>(
      fromMax: true,
      isStretch: true,
      innerPadding: EdgeInsets.all(5.0),
      initialValue: initialValue,
      children: itemsMenu,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLong),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      thumbDecoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
      onValueChanged: (i) {
        onValueChanged(i);
      },
    );
  }
}
