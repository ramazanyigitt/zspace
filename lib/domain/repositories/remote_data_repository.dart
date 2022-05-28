import '../../data/models/inventory_item_model.dart';
import '../../data/models/market_item_model.dart';
import '../../data/models/user_model.dart';

abstract class RemoteDataRepository {
  Future<UserModel> register();

  Future<UserModel> login();

  Future<UserModel> getProfile();

  Future<List<InventoryItemModel>> getInventory();

  Future<List<InventoryItemModel>> getEquippedInventory();

  Future<bool> equipItem();

  Future<bool> unEquipItem();

  Future<bool> buyItem();

  Future<bool> sellItem();

  Future<List<MarketItemModel>> getMarketItems();
}
