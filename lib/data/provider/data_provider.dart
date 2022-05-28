import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, bool>> buyItem(int marketItemId) {
    // TODO: implement buyItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> equipItem(int inventoryItemId) {
    // TODO: implement equipItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<InventoryItem>>> getEquippedInventory() {
    // TODO: implement getEquippedInventory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<InventoryItem>>> getInventory() {
    // TODO: implement getInventory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MarketItemModel>>> getMarketItems() async {
    try {
      final remoteData = await remoteDataSource.getMarketItems();
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
      final remoteData = await remoteDataSource.login();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, User>> register(String username, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sellItem(int inventoryItemId) {
    // TODO: implement sellItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> unEquipItem(int inventoryItemId) {
    // TODO: implement unEquipItem
    throw UnimplementedError();
  }
}
