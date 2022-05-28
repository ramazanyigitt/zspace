import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/features/_components/theme_button_icon.dart';
import 'package:zspace/features/home/main_menu/main_menu_viewmodel.dart';
import '../../../core/utils/lottie/lottie_cache.dart';
import '../../../injection_container.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainMenuViewModel>.nonReactive(
      viewModelBuilder: () => MainMenuViewModel(),
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
                      child: Text(
                        "Z-Space".tr,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(52),
                          fontWeight: FontWeight.bold,
                          color: AppTheme().greyScale5,
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ThemeButtonIcon(
                        'play_button'.tr,
                        onTap: viewModel.routeToEpisodesPage,
                        buttonIcon: Icons.play_circle,
                        opacity: 0.4,
                        iconColor: AppTheme().greyScale4,
                        textColor: AppTheme().greyScale5,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ThemeButtonIcon(
                            'inventory_button'.tr,
                            onTap: viewModel.routeToInventoryPage,
                            buttonIcon: Icons.inventory,
                            opacity: 0.4,
                            iconColor: AppTheme().greyScale4,
                            textColor: AppTheme().greyScale5,
                          ),
                          ThemeButtonIcon(
                            'market_button'.tr,
                            onTap: viewModel.routeToMarketPage,
                            buttonIcon: Icons.shopping_basket,
                            opacity: 0.4,
                            iconColor: AppTheme().greyScale4,
                            textColor: AppTheme().greyScale5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ThemeButtonIcon(
                        'settings_button'.tr,
                        onTap: () {},
                        buttonIcon: Icons.settings,
                        opacity: 0.4,
                        iconColor: AppTheme().greyScale4,
                        textColor: AppTheme().greyScale5,
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
