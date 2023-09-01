import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonFooterWidget extends StatelessWidget {
  const SkeletonFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                SkeletonAvatar(
                    style: SkeletonAvatarStyle(width: 20, height: 20)),
                SizedBox(width: 8),
                SkeletonAvatar(
                    style: SkeletonAvatarStyle(width: 20, height: 20)),
                SizedBox(width: 8),
                SkeletonAvatar(
                    style: SkeletonAvatarStyle(width: 20, height: 20)),
              ],
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 16,
                  width: 64,
                  borderRadius: BorderRadius.circular(8)),
            )
          ],
        ));
  }
}
