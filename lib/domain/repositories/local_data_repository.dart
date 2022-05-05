import 'package:zspace/data/models/inventory_item_model.dart';
import 'package:zspace/data/models/market_item_model.dart';
import 'package:zspace/data/models/user_model.dart';

abstract class LocalDataRepository {
  Future<UserModel> getUser();

  Future<void> saveUser(UserModel userModel);

  Future<void> deleteUser();

  Future<void> saveInventory(List<InventoryItemModel> inventoryItemModels);

  Future<List<InventoryItemModel>> getInventory();

  Future<void> saveEquippedInventory(
      List<InventoryItemModel> inventoryItemModels);

  Future<List<InventoryItemModel>> getEquippedInventory();

  Future<bool> equipItem(int itemId);

  Future<bool> unEquipItem(int itemId);

  Future<void> saveMarketItems(List<MarketItemModel> marketItemModels);

  Future<List<MarketItemModel>> getMarketItems();
}
