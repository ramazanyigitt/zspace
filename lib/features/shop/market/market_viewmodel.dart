import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import '../../../data/enums/win_point_category.dart';
import '../../../data/models/market_item_model.dart';
import '../../../domain/repositories/data_repository.dart';

import '../../../injection_container.dart';

class MarketViewModel extends BaseViewModel {
  String category = 'All';
  late List<MarketItemModel> marketItems;
  late bool isInited;
  late bool isLoading;

  late MarketCategory selectedCategory;
  late MarketDirection selectedDirection;
  late bool selectedExpire;

  Future<void> init() async {
    marketItems = [];
    selectedExpire = false;
    selectedCategory = MarketCategory.All;
    selectedDirection = MarketDirection.asc;

    isInited = false;
    isLoading = true;
    await Future.wait([
      getMarketItems(),
    ]);
    isLoading = false;
    isInited = true;
    notifyListeners();
  }

  Future<void> changeCategory(MarketCategory category) async {
    selectedCategory = category;
    isLoading = true;
    notifyListeners();
    await getMarketItems();
    isLoading = false;
    notifyListeners();
  }

  Future getMarketItems() async {
    final data =
        await locator<DataRepository>().getMarketItems(selectedCategory);
    if (data is Right) {
      marketItems = (data as Right).value;
    } else {
      marketItems = [];
    }
  }

  routeToItemDetailPage(int id) {}
}
