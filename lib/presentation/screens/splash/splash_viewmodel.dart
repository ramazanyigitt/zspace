import 'dart:developer';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/core/utils/lottie/lottie_cache.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/presentation/screens/main_menu/main_menu_page.dart';
import 'package:zspace/shared/app_images.dart';

import '../../../core/services/user_service.dart';
import '../../../domain/repositories/data_repository.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> init() async {
    await locator<LottieCache>().add(AppImages.spaceBackground.appLottie);
    await locator<LottieCache>().add(AppImages.saturn.appLottie);
    await locator<LottieCache>().add(AppImages.starShip.appLottie);
    final user = await locator<DataRepository>().login('', '');
    if (user.isRight()) locator<UserService>().setUser((user as Right).value);
    log('Access token: ${locator<UserService>().getUser()?.accessToken}');

    Get.off(() => MainMenuPage());
  }
}
