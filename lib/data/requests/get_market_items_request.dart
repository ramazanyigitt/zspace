import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class GetMarketItemsRequest extends IRestApiRequest {
  final int? maxId, take;
  final String? category;
  GetMarketItemsRequest({
    this.maxId,
    this.take,
    this.category,
  }) {
    this.endPoint = locator<RemoteDataRepository>().baseUrl + 'market/getItems';
    this.requestMethod = RequestMethod.GET;
    this.queryParameters = {
      if (maxId != null) 'maxId': maxId,
      if (take != null) 'take': take,
      if (category != null) 'category': category,
    };
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
