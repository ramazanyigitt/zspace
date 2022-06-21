import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class GetCurrentLevelRequest extends IRestApiRequest {
  GetCurrentLevelRequest() {
    this.endPoint =
        locator<RemoteDataRepository>().baseUrl + 'episode/getCurrentLevel';
    this.requestMethod = RequestMethod.GET;
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
