import 'dart:developer';

import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:zspace/data/models/episode_model.dart';
import 'package:zspace/data/requests/get_equipped_inventory_request.dart';
import 'package:zspace/data/requests/get_inventory_request.dart';
import 'package:zspace/data/requests/get_market_items_request.dart';
import '../enums/win_point_category.dart';
import '../models/error_model.dart';
import '../models/market_item_model.dart';
import '../models/inventory_item_model.dart';
import '../../injection_container.dart';
import '../../core/errors/failure.dart';
import '../../core/services/user_service.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

import '../../domain/repositories/remote_data_repository.dart';
import '../requests/but_item_request.dart';
import '../requests/equip_item_request.dart';
import '../requests/get_episodes_request.dart';
import '../requests/login_request.dart';
import '../requests/register_request.dart';
import '../requests/unequip_item_request.dart';

class HttpDataSource implements RemoteDataRepository {
  @override
  String get baseUrl => 'http://10.0.2.2:8080/';

  @override
  Future<List<InventoryItemModel>> buyItem(int marketItemId) async {
    try {
      log('User is: ${locator<LocalDataRepository>().getUser()}');

      log('Access token is: ${locator<LocalDataRepository>().getUser().accessToken}');
      final request = await locator<RestApiHttpService>().request(
        BuyItemRequest(
          itemId: marketItemId,
        ),
      );
      try {
        final response = locator<RestApiHttpService>()
            .handleResponseList<InventoryItemModel>(
          request,
          parseModel: InventoryItemModel(),
          isRawJson: false,
        );

        return response;
      } catch (e) {
        final response =
            locator<RestApiHttpService>().handleResponse<ErrorModel>(
          request,
          parseModel: ErrorModel(),
          isRawJson: false,
        );
        throw response.message!;
      }
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<InventoryItemModel>> getEquippedInventory() async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestAndHandleList<InventoryItemModel>(
        GetEquippedInventoryRequest(),
        parseModel: InventoryItemModel(),
        isRawJson: false,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<InventoryItemModel>> getInventory() async {
    try {
      final response = await locator<RestApiHttpService>()
          .requestAndHandleList<InventoryItemModel>(
        GetInventoryRequest(),
        parseModel: InventoryItemModel(),
        isRawJson: false,
      );
      log('Inventory: $response');
      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<MarketItemModel>> getMarketItems(MarketCategory category) async {
    try {
      log('User is: ${locator<LocalDataRepository>().getUser()}');

      log('Access token is: ${locator<LocalDataRepository>().getUser().accessToken}');
      final response = await locator<RestApiHttpService>()
          .requestAndHandleList<MarketItemModel>(
        GetMarketItemsRequest(
          category: category == MarketCategory.All ? null : category.name,
        ),
        parseModel: MarketItemModel(),
        isRawJson: false,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<UserModel> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final response =
          await locator<RestApiHttpService>().requestAndHandle<UserModel>(
        LoginRequest(
          username: username,
          password: password,
        ),
        parseModel: UserModel(),
      );

      return response;
    } catch (e) {
      log('Login error : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<UserModel> register(String username, String password) async {
    try {
      final response =
          await locator<RestApiHttpService>().requestAndHandle<UserModel>(
        RegisterRequest(
          username: username,
          password: password,
        ),
        parseModel: UserModel(),
      );

      return response;
    } catch (e) {
      log('Login error : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> sellItem() {
    // TODO: implement sellItem
    throw UnimplementedError();
  }

  @override
  Future<InventoryItemModel> equipItem(int inventoryItemId) async {
    try {
      final request = await locator<RestApiHttpService>().request(
        EquipItemRequest(
          inventoryItemId: inventoryItemId,
        ),
      );
      try {
        final response =
            locator<RestApiHttpService>().handleResponse<InventoryItemModel>(
          request,
          parseModel: InventoryItemModel(),
          isRawJson: false,
        );

        return response;
      } catch (e) {
        final response =
            locator<RestApiHttpService>().handleResponse<ErrorModel>(
          request,
          parseModel: ErrorModel(),
          isRawJson: false,
        );
        throw response.message!;
      }
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<InventoryItemModel> unEquipItem(int inventoryItemId) async {
    try {
      final request = await locator<RestApiHttpService>().request(
        UnEquipItemRequest(
          inventoryItemId: inventoryItemId,
        ),
      );
      try {
        final response =
            locator<RestApiHttpService>().handleResponse<InventoryItemModel>(
          request,
          parseModel: InventoryItemModel(),
          isRawJson: false,
        );

        return response;
      } catch (e) {
        final response =
            locator<RestApiHttpService>().handleResponse<ErrorModel>(
          request,
          parseModel: ErrorModel(),
          isRawJson: false,
        );
        throw response.message!;
      }
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodes() async {
    try {
      log('User is: ${locator<LocalDataRepository>().getUser()}');

      log('Access token is: ${locator<LocalDataRepository>().getUser().accessToken}');
      final response = await locator<RestApiHttpService>()
          .requestAndHandleList<EpisodeModel>(
        GetEpisodesRequest(),
        parseModel: EpisodeModel(),
        isRawJson: false,
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  /*@override
  Future<User> getUser() async {
    final user = await RespApiHttpService().requestAndHandle<UserModel>(
      RestApiRequest(
        endPoint: baseUrl + 'signIn',
        requestMethod: RequestMethod.POST,
        body: {
          'email': '',
          'password': '',
        },
      ),
      parseModel: UserModel(),
      removeBaseUrl: true,
    );
    return user;
  }*/
}
