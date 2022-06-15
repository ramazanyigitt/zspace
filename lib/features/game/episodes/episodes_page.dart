import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import '../../_components/theme_button.dart';
import 'episodes_viewmodel.dart';
import 'widgets/episode_planet.dart';

class EpisodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> showLevelTitle = ValueNotifier(true);
    int currentEpisode = 0;
    return ViewModelBuilder<EpisodesViewModel>.reactive(
        viewModelBuilder: () => EpisodesViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
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
                  child: ValueListenableBuilder<bool>(
                    valueListenable: showLevelTitle,
                    builder: (context, value, child) {
                      return Visibility(
                        visible: value,
                        child: Container(
                          margin: EdgeInsets.only(top: 80),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Episode ${currentEpisode + 1}',
                            style: AppTheme().largeParagraphBoldText.copyWith(
                                  fontSize: 36,
                                  color: AppTheme().greyScale5,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                NotificationListener(
                  onNotification: (notif) {
                    if (notif is ScrollStartNotification) {
                      showLevelTitle.value = false;
                    }
                    if (notif is ScrollEndNotification) {
                      showLevelTitle.value = true;
                    }
                    return false;
                  },
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return StagePlanet(viewModel.episodes[index]);
                    },
                    itemCount: viewModel.episodes.length,
                    viewportFraction: 0.55,
                    scale: 0.50,
                    loop: false,
                    onIndexChanged: (i) {
                      currentEpisode = i;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: ThemeButton(
                      text: "Enter orbit",
                      width: 200,
                      height: 100,
                      elevation: 0,
                      onTap: () {
                        viewModel.routeToLevelInformationPage(
                          viewModel.episodes[currentEpisode],
                          viewModel.episodes[currentEpisode].levels!.first,
                        );
                      },
                      textStyle: AppTheme().paragraphSemiBoldText,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
