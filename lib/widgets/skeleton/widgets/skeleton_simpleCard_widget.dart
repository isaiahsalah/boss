// ignore_for_file: file_names

import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSimpleCardWidget extends StatelessWidget {
  const SkeletonSimpleCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimensions.spacingSmall),
      child: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          width: double.infinity,
          height: 208,
        ),
      ),
    );
  }
}
