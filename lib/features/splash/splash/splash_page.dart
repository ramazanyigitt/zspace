import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/_components/local_image_box.dart';
import 'package:zspace/features/splash/splash/splash_viewmodel.dart';
import 'package:zspace/shared/app_theme.dart';

import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: LottieBuilder.asset(
                  AppImages.spaceBackground.appLottie,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 2.67,
                      colors: <Color>[
                        Colors.yellow.withAlpha(100),
                        Colors.black.withAlpha(40)
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocalImageBox(
                        width: 128,
                        height: 128,
                        imgUrl: AppImages.portals.base + 'boss_portal.png',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Z-Space',
                        style: AppTheme().largeParagraphBoldText.copyWith(
                              color: Colors.white,
                              fontSize: 46,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
