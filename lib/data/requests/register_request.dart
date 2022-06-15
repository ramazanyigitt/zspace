import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class RegisterRequest extends IRestApiRequest {
  final String username, password;
  RegisterRequest({
    required this.username,
    required this.password,
  }) {
    this.endPoint = locator<RemoteDataRepository>().baseUrl + 'auth/register';
    this.requestMethod = RequestMethod.POST;
    this.body = {
      'userName': username,
      'password': password,
    };
  }
}
