import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSliderWidget extends StatelessWidget {
  const SkeletonSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingSmall),
        child: SkeletonLine(
          style: SkeletonLineStyle(
              height: 50,
              width: double.infinity,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLong)),
        ));
  }
}
