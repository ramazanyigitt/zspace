import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/core/utils/router/app_router.dart';
import 'package:zspace/presentation/screens/episodes/episodes_page.dart';
import 'package:zspace/presentation/screens/inventory/inventory_page.dart';
import 'package:zspace/presentation/screens/market/market_page.dart';
import 'package:zspace/presentation/widgets/theme_button_icon.dart';

class MainMenuViewModel extends BaseViewModel {
  //
  ValueNotifier<double> startSigma = ValueNotifier<double>(0.0);

  void init() {}

  routeToEpisodesPage() {
    Get.to(
      () => EpisodesPage(),
    );
  }

  routeToSettingsPage() {}

  routeToMarketPage() {
    Get.to(() => MarketPage());
  }

  routeToInventoryPage() {
    Get.to(() => InventoryPage());
  }
}
