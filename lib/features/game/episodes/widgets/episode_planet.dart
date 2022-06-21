import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zspace/data/models/episode_model.dart';
import 'package:zspace/domain/repositories/local_data_repository.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/shared/app_images.dart';

import '../../../../data/models/user_model.dart';
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
      child: StreamBuilder<UserModel>(
        initialData: locator<LocalDataRepository>().getUser(),
        stream: locator<LocalDataRepository>().userStream,
        builder: (context, snapshot) {
          final isEpisodeUnlocked = ((episode.levels?.any(
                      (element) => element.level == snapshot.data?.levelId)) ==
                  true) ||
              (episode.levels!.last.level! <
                  locator<LocalDataRepository>().getUser().levelId!);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200.w,
                  child: Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          !isEpisodeUnlocked
                              ? Colors.black.withOpacity(0.75)
                              : Colors.transparent,
                          BlendMode.srcATop,
                        ),
                        child: Center(
                          child: Image.asset(
                            episode.image!.appImage,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      !isEpisodeUnlocked
                          ? Positioned.fill(
                              child: Container(
                                width: 200.w,
                                height: 200.w,
                                //color: Colors.black.withOpacity(0.4),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 50.w,
                                ),
                              ),
                            )
                          : Container(),
                    ],
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
          );
        },
      ),
    );
  }
}
