import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/data/models/episode_model.dart';

import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../data/enums/creature_types.dart';
import '../../../data/models/level_model.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import '../../_components/theme_button.dart';
import 'level_information_viewmodel.dart';

part 'creatures_information_card.dart';

class LevelInformationPage extends StatelessWidget {
  final EpisodeModel episode;
  final LevelModel level;
  const LevelInformationPage({
    Key? key,
    required this.episode,
    required this.level,
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
                        margin: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Level ${level.level}',
                          style: AppTheme().largeParagraphBoldText.copyWith(
                                fontSize: 36,
                                color: AppTheme().greyScale5,
                              ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 130,
                          height: 130,
                          child: Image.asset(
                            episode.image!.appImage,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 60, bottom: 10),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Creatures',
                              style: AppTheme().largeParagraphBoldText.copyWith(
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
                            child: _CreaturesInformationCard(
                              level: level,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              child: ThemeButton(
                                text: "Start",
                                width: 200,
                                height: 67,
                                elevation: 0,
                                onTap: () {
                                  viewModel.routeToGame(episode, level);
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
      },
    );
  }
}
