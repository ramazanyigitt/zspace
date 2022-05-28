import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/level_model.dart';
import '../gameplay/game_page.dart';

class LevelInformationViewModel extends BaseViewModel {
  routeToGame(LevelModel level) {
    Get.to(
      () => GameWidget(
        game: GamePage(
          level,
        ),
        loadingBuilder: (context) {
          return Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
