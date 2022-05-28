import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../game/episodes/episodes_page.dart';
import '../../shop/market/market_page.dart';
import '../inventory/inventory_page.dart';

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
