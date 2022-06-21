import 'package:rest_api_package/requests/rest_api_request.dart';

import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';
import '../../injection_container.dart';

class AddCreditRequest extends IRestApiRequest {
  final int amount;
  AddCreditRequest({
    required this.amount,
  }) {
    this.endPoint = locator<RemoteDataRepository>().baseUrl + 'user/addCredit';
    this.requestMethod = RequestMethod.POST;
    this.body = {
      'amount': amount,
    };
    this.bearerToken = locator<LocalDataRepository>().getUser().accessToken;
  }
}
