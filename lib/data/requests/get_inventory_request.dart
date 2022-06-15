import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class GetInventoryRequest extends IRestApiRequest {
  final int? maxId, take;

  GetInventoryRequest({
    this.maxId,
    this.take,
  }) {
    this.endPoint =
        locator<RemoteDataRepository>().baseUrl + 'inventory/getInventory';
    this.requestMethod = RequestMethod.GET;
    this.queryParameters = {
      if (maxId != null) 'maxId': maxId,
      if (take != null) 'take': take,
    };
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
