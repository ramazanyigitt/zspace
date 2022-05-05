import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:zspace/core/services/user_service.dart';
import 'package:zspace/core/utils/lottie/lottie_cache.dart';
import 'data/data_sources/local_json_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'core/platform/network_info.dart';
import 'data/data_sources/http_data_source.dart';
import 'data/provider/data_provider.dart';
import 'domain/repositories/data_repository.dart';
import 'domain/repositories/local_data_repository.dart';
import 'domain/repositories/remote_data_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //!Features
  //Usecases
  //locator.registerLazySingleton(() => GetOffers(locator()));
  //locator.registerLazySingleton(() => GetProducts(locator()));

  //Repository
  locator.registerLazySingleton<DataRepository>(
    () => DataProvider(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //Data
  /*final hiveDataSource = HiveDataSource();
  await hiveDataSource.init();*/
  locator.registerLazySingleton<LocalDataRepository>(
    () => JsonLocalDataSource(),
  );

  locator.registerLazySingleton<RemoteDataRepository>(
    () => HttpDataSource(),
  );

  //!Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator()),
  );
  locator.registerLazySingleton<RestApiHttpService>(
    () => RestApiHttpService(Dio(), DefaultCookieJar()),
  );

  //!External
  locator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
  locator.registerLazySingleton(
    () => LottieCache(),
  );
  locator.registerLazySingleton(
    () => UserService(),
  );
}
