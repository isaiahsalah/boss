import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonTitleWidget extends StatelessWidget {
  const SkeletonTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 1,
                lineStyle: SkeletonLineStyle(
                  alignment: Alignment.centerLeft,
                  randomLength: true,
                  height: 12,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 6,
                  maxLength: MediaQuery.of(context).size.width / 3,
                )),
          ),
          const SkeletonAvatar(
              style: SkeletonAvatarStyle(width: 20, height: 20))
        ],
      ),
    );
  }
}
