// ignore_for_file: file_names

import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/skeleton/widgets/skeleton_footer_widget.dart';
import 'package:boss/widgets/skeleton/widgets/skeleton_simpleCard_widget.dart';
import 'package:boss/widgets/skeleton/widgets/skeleton_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonCardWidget extends StatelessWidget {
  const SkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimensions.spacingSmall),
      child: SkeletonItem(
        child: Column(
          children: [
            SkeletonTitleWidget(),
            SkeletonSimpleCardWidget(),
            SkeletonFooterWidget(),
          ],
        ),
      ),
    );
  }
}
