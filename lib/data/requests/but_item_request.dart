import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class BuyItemRequest extends IRestApiRequest {
  final int itemId;

  BuyItemRequest({
    required this.itemId,
  }) {
    this.endPoint = locator<RemoteDataRepository>().baseUrl + 'market/buyItem';
    this.requestMethod = RequestMethod.POST;
    this.body = {
      'itemId': itemId,
    };
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
