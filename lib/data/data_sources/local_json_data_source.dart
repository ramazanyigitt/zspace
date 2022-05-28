import '../../domain/repositories/local_data_repository.dart';
import '../models/inventory_item_model.dart';
import '../models/market_item_model.dart';
import '../models/user_model.dart';

class JsonLocalDataSource implements LocalDataRepository {
  @override
  Future<void> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<bool> equipItem(int itemId) {
    // TODO: implement equipItem
    throw UnimplementedError();
  }

  @override
  Future<List<InventoryItemModel>> getEquippedInventory() {
    // TODO: implement getEquippedInventory
    throw UnimplementedError();
  }

  @override
  Future<List<InventoryItemModel>> getInventory() {
    // TODO: implement getInventory
    throw UnimplementedError();
  }

  @override
  Future<List<MarketItemModel>> getMarketItems() {
    // TODO: implement getMarketItems
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveEquippedInventory(
      List<InventoryItemModel> inventoryItemModels) {
    // TODO: implement saveEquippedInventory
    throw UnimplementedError();
  }

  @override
  Future<void> saveInventory(List<InventoryItemModel> inventoryItemModels) {
    // TODO: implement saveInventory
    throw UnimplementedError();
  }

  @override
  Future<void> saveMarketItems(List<MarketItemModel> marketItemModels) {
    // TODO: implement saveMarketItems
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(UserModel userModel) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<bool> unEquipItem(int itemId) {
    // TODO: implement unEquipItem
    throw UnimplementedError();
  }
  /*@override
  Future<User> getUser() async {
    final String? jsonString =
        await rootBundle.loadString('test/fixtures/user.json');

    if (jsonString != null) {
      final data = await json.decode(jsonString);
      return Future.value(UserModel.fromJson(data));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(User offerModel) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }*/
}
