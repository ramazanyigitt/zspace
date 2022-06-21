import 'dart:async';

import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import '../models/market_item_model.dart';
import '../models/inventory_item_model.dart';
import '../models/user_model.dart';

import '../../domain/repositories/local_data_repository.dart';

class HiveDataSource implements LocalDataRepository {
  final _userBoxName = 'users';

  @override
  late Stream<UserModel> userStream;

  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(_userBoxName);
    if (Hive.box<UserModel>(_userBoxName).values.length <= 0) {
      await saveUser(UserModel());
    }
    this.userStream = Hive.box<UserModel>(_userBoxName).watch().map((box) {
      log('UserStream test!');
      return box.value;
    });
  }

  @override
  Future<void> saveUser(UserModel userModel) async {
    var box = Hive.box<UserModel>(_userBoxName);

    if (box.length > 0) {
      box.values.first.updateFromJson(userModel.toJson());
      await box.values.first.save();
      return;
    }

    await box.add(userModel);
  }

  @override
  UserModel getUser() {
    var box = Hive.box<UserModel>(_userBoxName);
    return box.values.first;
  }

  @override
  Future<void> deleteUser() async {
    var box = Hive.box<UserModel>(_userBoxName);
    box.values.first.accessToken = null;
    box.values.first.createdAt = null;
    box.values.first.credit = null;
    box.values.first.emailAddress = null;
    box.values.first.levelId = null;
    box.values.first.userName = null;
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
  Future<bool> unEquipItem(int itemId) {
    // TODO: implement unEquipItem
    throw UnimplementedError();
  }
}
