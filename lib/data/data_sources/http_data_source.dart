import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

import '../../domain/repositories/remote_data_repository.dart';

class HttpDataSource implements RemoteDataRepository {
  final baseUrl = 'localhost:8080/';

  @override
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
  }
}
