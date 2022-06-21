import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class SetLevelRequest extends IRestApiRequest {
  final int levelId;
  SetLevelRequest(this.levelId) {
    this.endPoint =
        locator<RemoteDataRepository>().baseUrl + 'episode/setLevel';
    this.requestMethod = RequestMethod.POST;
    this.body = {
      'levelId': levelId,
    };
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
