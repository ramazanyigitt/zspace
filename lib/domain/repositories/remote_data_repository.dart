import 'package:zspace/data/models/episode_model.dart';

import '../../data/enums/win_point_category.dart';
import '../../data/models/inventory_item_model.dart';
import '../../data/models/market_item_model.dart';
import '../../data/models/user_model.dart';

abstract class RemoteDataRepository {
  String get baseUrl;

  Future<UserModel> register(String username, String password);

  Future<UserModel> login(String username, String password);

  Future<UserModel> getProfile();

  Future<List<InventoryItemModel>> getInventory();

  Future<List<InventoryItemModel>> getEquippedInventory();

  Future<InventoryItemModel> equipItem(int inventoryItemId);

  Future<InventoryItemModel> unEquipItem(int inventoryItemId);

  Future<List<InventoryItemModel>> buyItem(int marketItemId);

  Future<bool> sellItem();

  Future<List<MarketItemModel>> getMarketItems(MarketCategory category);

  Future<List<EpisodeModel>> getEpisodes();
}
