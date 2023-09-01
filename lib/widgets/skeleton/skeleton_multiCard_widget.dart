// ignore_for_file: file_names

import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/skeleton/widgets/skeleton_doubleCard_widget.dart';
import 'package:boss/widgets/skeleton/widgets/skeleton_slider_widget.dart';
import 'package:boss/widgets/skeleton/widgets/skeleton_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonMultiCardWidget extends StatelessWidget {
  const SkeletonMultiCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimensions.spacingSmall),
      child: SkeletonItem(
        child: Column(
          children: [
            SkeletonTitleWidget(),
            SkeletonDobleCardWidget(),
            SkeletonDobleCardWidget(),
            SkeletonSliderWidget(),
          ],
        ),
      ),
    );
  }
}
