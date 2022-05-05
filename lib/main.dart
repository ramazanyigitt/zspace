import 'package:flame/components.dart' hide Draggable;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import 'package:zspace/presentation/screens/main_menu/main_menu_page.dart';
import 'package:zspace/presentation/screens/main_menu/main_menu_viewmodel.dart';
import 'package:zspace/presentation/screens/splash/splash_page.dart';
import 'package:zspace/shared/app_theme.dart';
import 'data/localization/messages.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        home: SplashPage(),
        theme: ThemeData(
          primaryColor: AppTheme().primaryColor,
          secondaryHeaderColor: AppTheme().secondaryColor,
          accentColor: AppTheme().primaryColor,
        ),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    ),
  );
}
