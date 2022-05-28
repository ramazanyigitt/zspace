import 'dart:developer';

import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import '../models/market_item_model.dart';
import '../models/inventory_item_model.dart';
import '../../injection_container.dart';
import '../../core/errors/failure.dart';
import '../../core/services/user_service.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

import '../../domain/repositories/remote_data_repository.dart';

class HttpDataSource implements RemoteDataRepository {
  final baseUrl = 'http://3746-188-132-136-217.ngrok.io/';

  @override
  Future<bool> buyItem() {
    // TODO: implement buyItem
    throw UnimplementedError();
  }

  @override
  Future<bool> equipItem() {
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
  Future<List<MarketItemModel>> getMarketItems() async {
    try {
      log('Access token is: ${locator<UserService>().getUser()?.accessToken}');
      final response = await locator<RestApiHttpService>().request(
        RestApiRequest(
          endPoint: baseUrl + 'market/getItems',
          requestMethod: RequestMethod.GET,
          queryParameters: {
            //maxId: '${maxId}',
            //take: '${take}',
            //'category': 'All',
          },
          bearerToken: locator<UserService>().getUser()?.accessToken,
        ),
      );
      log('Response: $response');
      log('header: ${response.requestOptions.headers}');

      final result =
          locator<RestApiHttpService>().handleResponseList<MarketItemModel>(
        response,
        parseModel: MarketItemModel(),
        isRawJson: false,
      );
      return result;
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
  Future<UserModel> login() async {
    try {
      final response =
          await locator<RestApiHttpService>().requestAndHandle<UserModel>(
        RestApiRequest(
          endPoint: baseUrl + 'auth/login',
          requestMethod: RequestMethod.POST,
          body: {
            'userName': 'admin',
            'password': 'admin',
          },
        ),
        parseModel: UserModel(),
      );

      return response;
    } catch (e) {
      log('e : $e');
      throw ServerFailure(errorMessage: e.toString());
    }
  }

  @override
  Future<UserModel> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<bool> sellItem() {
    // TODO: implement sellItem
    throw UnimplementedError();
  }

  @override
  Future<bool> unEquipItem() {
    // TODO: implement unEquipItem
    throw UnimplementedError();
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
