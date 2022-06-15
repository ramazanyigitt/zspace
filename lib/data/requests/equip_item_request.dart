import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class EquipItemRequest extends IRestApiRequest {
  final int inventoryItemId;

  EquipItemRequest({
    required this.inventoryItemId,
  }) {
    this.endPoint =
        locator<RemoteDataRepository>().baseUrl + 'inventory/equipItem';
    this.requestMethod = RequestMethod.POST;
    this.body = {
      'inventoryItemId': inventoryItemId,
    };
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
