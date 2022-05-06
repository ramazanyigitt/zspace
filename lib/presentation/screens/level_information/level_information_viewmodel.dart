import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/presentation/screens/game/game_page.dart';
import 'package:zspace/presentation/widgets/overlay/lock_overlay.dart';
import 'package:zspace/shared/app_theme.dart';

class LevelInformationViewModel extends BaseViewModel {
  routeToGame() {
    Get.to(
      () => GameWidget(
        game: GamePage(),
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
