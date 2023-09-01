// ignore_for_file: file_names

import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonDobleCardWidget extends StatelessWidget {
  const SkeletonDobleCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimensions.spacingSmall),
      child: Row(
        children: [
          Expanded(
            child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: 20, height: 180)),
          ),
          SizedBox(width: AppDimensions.spacingMedium),
          Expanded(
            child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: 20, height: 180)),
          ),
        ],
      ),
    );
  }
}
