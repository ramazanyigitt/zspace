import 'package:dartz/dartz.dart';
import 'package:zspace/data/enums/win_point_category.dart';
import 'package:zspace/domain/entities/episode.dart';

import '../../core/errors/failure.dart';
import '../entities/inventory_item.dart';
import '../entities/market_item.dart';
import '../entities/user.dart';

abstract class DataRepository {
  Future<Either<Failure, User>> register(String username, String password);

  Future<Either<Failure, User>> login(String username, String password);

  Future<Either<Failure, User>> getProfile();

  Future<Either<Failure, List<InventoryItem>>> getInventory();

  Future<Either<Failure, List<InventoryItem>>> getEquippedInventory();

  Future<Either<Failure, InventoryItem>> equipItem(int inventoryItemId);

  Future<Either<Failure, InventoryItem>> unEquipItem(int inventoryItemId);

  Future<Either<Failure, List<InventoryItem>>> buyItem(int marketItemId);

  Future<Either<Failure, bool>> sellItem(int inventoryItemId);

  Future<Either<Failure, List<MarketItem>>> getMarketItems(
      MarketCategory category);

  Future<Either<Failure, List<Episode>>> getEpisodes();
}
