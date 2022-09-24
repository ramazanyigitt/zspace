import 'package:dartz/dartz.dart';
import 'package:zspace/domain/entities/episode.dart';
import 'package:zspace/domain/entities/level.dart';
import '../enums/win_point_category.dart';
import '../models/inventory_item_model.dart';
import '../models/market_item_model.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/market_item.dart';
import '../../domain/entities/inventory_item.dart';

import '../../../../core/platform/network_info.dart';
import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/data_repository.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';

class DataProvider implements DataRepository {
  final RemoteDataRepository remoteDataSource;
  final LocalDataRepository localDataSource;
  final NetworkInfo networkInfo;

  DataProvider({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _getDataList<T, K extends T>({
    required Future<K> Function() getData,
    required Future<void> Function(K) saveCache,
    required Future<T> Function() getCache,
  }) async {
    if (false) {
      //await networkInfo.isConnected
      try {
        final remoteData = await getData();
        saveCache(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await getCache();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<InventoryItem>>> buyItem(int marketItemId) async {
    try {
      final remoteData = await remoteDataSource.buyItem(marketItemId);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<InventoryItem>>> getEquippedInventory() async {
    try {
      final remoteData = await remoteDataSource.getEquippedInventory();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<InventoryItem>>> getInventory() async {
    try {
      final remoteData = await remoteDataSource.getInventory();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<MarketItemModel>>> getMarketItems(
      MarketCategory category) async {
    try {
      final remoteData = await remoteDataSource.getMarketItems(category);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> login(
      String username, String password) async {
    try {
      final remoteData = await remoteDataSource.login(username, password);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, User>> register(
      String username, String password) async {
    try {
      final remoteData = await remoteDataSource.register(username, password);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> sellItem(int inventoryItemId) {
    // TODO: implement sellItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, InventoryItem>> equipItem(int inventoryItemId) async {
    try {
      final remoteData = await remoteDataSource.equipItem(inventoryItemId);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, InventoryItem>> unEquipItem(
      int inventoryItemId) async {
    try {
      final remoteData = await remoteDataSource.unEquipItem(inventoryItemId);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getEpisodes() async {
    try {
      final remoteData = await remoteDataSource.getEpisodes();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> setLevel(int levelId) async {
    try {
      final remoteData = await remoteDataSource.setLevel(levelId);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Level>> getCurrentLevel() async {
    try {
      final remoteData = await remoteDataSource.getCurrentLevel();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> addCredit(int amount) async {
    try {
      final remoteData = await remoteDataSource.addCredit(amount);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }
}
