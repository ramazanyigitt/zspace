import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/core/utils/lottie/lottie_cache.dart';
import 'package:zspace/injection_container.dart';
import 'package:zspace/presentation/screens/level_information/level_information_viewmodel.dart';
import 'package:zspace/presentation/widgets/theme_button.dart';
import 'package:zspace/shared/app_images.dart';
import 'package:zspace/shared/app_theme.dart';

class LevelInformationPage extends StatelessWidget {
  const LevelInformationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LevelInformationViewModel>.nonReactive(
        viewModelBuilder: () => LevelInformationViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              width: 1.sw,
              height: 1.sh,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: locator<LottieCache>().load(
                      AppImages.spaceBackground.appLottie,
                      Container(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.topLeft,
                          radius: 3,
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
                  SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Episode 1',
                            style: AppTheme().largeParagraphBoldText.copyWith(
                                  fontSize: 36,
                                  color: AppTheme().greyScale5,
                                ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              "assets/images/planet.png",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 80, bottom: 20),
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Creatures',
                                style:
                                    AppTheme().largeParagraphBoldText.copyWith(
                                          fontSize: 36,
                                          color: AppTheme().greyScale5,
                                        ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 1.sw,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(40),
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: ThemeButton(
                                  text: "Başlat",
                                  width: 200,
                                  height: 100,
                                  elevation: 0,
                                  onTap: () {
                                    viewModel.routeToGame();
                                  },
                                  textStyle: AppTheme().paragraphSemiBoldText,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
