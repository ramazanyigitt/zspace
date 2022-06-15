import 'dart:developer';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/authentication/login/login_page.dart';
import 'package:zspace/features/home/main_menu/main_menu_page.dart';
import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';

import '../../../core/services/user_service.dart';
import '../../../domain/repositories/data_repository.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> init(BuildContext context) async {
    await locator<LottieCache>().add(AppImages.spaceBackground.appLottie);
    await locator<LottieCache>().add(AppImages.saturn.appLottie);
    await locator<LottieCache>().add(AppImages.starShip.appLottie);
    precacheImage(
      AssetImage(AppImages.items.laserLevel1.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.laserLevel1.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.rocketLevel1.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.rocketLevel2.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.shieldLevel1.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.shieldLevel2.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.speedLevel1.appImage),
      context,
    );
    precacheImage(
      AssetImage(AppImages.items.speedLevel2.appImage),
      context,
    );
    //final user = await locator<DataRepository>().login('', '');
    //if (user.isRight()) locator<UserService>().setUser((user as Right).value);
    //log('Access token: ${locator<UserService>().getUser()?.accessToken}');
    await handleKeepLogin();
  }

  handleKeepLogin() async {
    var user = locator<LocalDataRepository>().getUser();
    log('User is: $user');
    if (user.stayLoggedIn == true) {
      if (user.userName != null) {
        Get.off(() => MainMenuPage());
      } else {
        Get.off(() => LoginPage());
      }
    } else {
      await locator<LocalDataRepository>().getUser().delete();
      await locator<LocalDataRepository>().saveUser(
        UserModel(
          stayLoggedIn: false,
        ),
      );
      Get.off(() => LoginPage());
    }
  }
}
