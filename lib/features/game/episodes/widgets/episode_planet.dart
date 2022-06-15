import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zspace/data/models/episode_model.dart';
import 'package:zspace/shared/app_images.dart';

import '../../../../shared/app_theme.dart';

class StagePlanet extends StatelessWidget {
  final EpisodeModel episode;
  StagePlanet(this.episode);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.fromLTRB(viewPortMargin, 0.w, 0.w, 0.w),
      width: 0.7.sw,
      height: 200.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200.w,
              child: Image.asset(
                episode.image!.appImage,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "${episode.name!}",
              style: AppTheme().paragraphSemiBoldText.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Total ${episode.levels!.length} Level",
              style: AppTheme().smallParagraphMediumText.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
