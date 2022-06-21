import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/_components/theme_button_icon.dart';
import 'package:zspace/features/settings/settings/settings_viewmodel.dart';
import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../authentication/login/login_page.dart';

part 'top_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.nonReactive(
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (model) => model.init(),
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
                Positioned(
                  top: 26,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: _TopBar(),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: 1.sw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ThemeButtonIcon(
                          'Language',
                          onTap: () {
                            //
                          },
                          buttonIcon: Icons.language_rounded,
                          opacity: 0.4,
                          iconColor: AppTheme().greyScale4,
                          textColor: AppTheme().greyScale5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ThemeButtonIcon(
                          'Logout',
                          onTap: () {
                            locator<LocalDataRepository>().deleteUser();
                            Get.offUntil(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false);
                          },
                          buttonIcon: Icons.logout,
                          opacity: 0.4,
                          iconColor: AppTheme().greyScale4,
                          textColor: AppTheme().greyScale5,
                        ),
                      ],
                    ),
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
