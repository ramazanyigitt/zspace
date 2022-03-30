part of '../rest_api_package.dart';

class RespApiHttpService {
  Future<Options> prepareOptions({bool authorize = false}) async {
    final Map<String, String> headers = <String, String>{};
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');
    headers.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json');

    if (authorize) {
      //headers.putIfAbsent(HttpHeaders.authorizationHeader, () => UserService().getToken!);
    }
    return Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 501) <= 500;
        });
  }

  Future<T> requestAndHandle<T>(
    RestApiRequest apiRequest, {
    bool removeBaseUrl = false,
    required dynamic parseModel,
  }) async {
    Response response = await request(apiRequest, removeBaseUrl: removeBaseUrl);
    return handleResponse<T>(response, parseModel: parseModel);
  }

  Future<List<T>> requestAndHandleList<T>(
    RestApiRequest apiRequest, {
    bool removeBaseUrl = false,
    required dynamic parseModel,
  }) async {
    Response response = await request(apiRequest, removeBaseUrl: removeBaseUrl);
    return handleResponseList<T>(response, parseModel: parseModel);
  }

  Future<Response> request(RestApiRequest apiRequest,
      {bool removeBaseUrl = false}) async {
    Response resp;
    String url = apiRequest.endPoint;

    Options options = await prepareOptions(authorize: apiRequest.authorize);

    try {
      if (apiRequest.requestMethod == RequestMethod.GET) {
        resp = await Dio().get(
          url,
          options: options,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await Dio().put(
          url,
          options: options,
          data: apiRequest.body,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await Dio().post(
          url,
          options: options,
          data: apiRequest.body,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.DELETE) {
        resp = await Dio().delete(
          url,
          options: options,
          queryParameters: apiRequest.queryParameters,
          data: apiRequest.body,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  Future<Response> requestFile(
    RestApiRequest apiRequest, {
    required String fileFieldName,
    required File file,
    Function(int, int)? onSendProgress,
  }) async {
    Response resp;
    String url = apiRequest.endPoint;

    Options options = await prepareOptions(authorize: apiRequest.authorize);

    var mfile = MultipartFile.fromBytes(
      file.readAsBytesSync(),
      filename: file.path.split('/').last,
    );
    var formData = FormData();

    formData.files.add(MapEntry(fileFieldName, mfile));

    apiRequest.body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    try {
      if (apiRequest.requestMethod == RequestMethod.PUT) {
        resp = await Dio().put(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
        );
      } else if (apiRequest.requestMethod == RequestMethod.POST) {
        resp = await Dio().post(
          url,
          options: options,
          data: formData,
          queryParameters: apiRequest.queryParameters,
          onSendProgress: onSendProgress,
        );
      } else {
        throw Exception("Error this request's method is undefined");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('DIO Error: $e');
    }
    return resp;
  }

  T handleResponse<T>(Response response, {required dynamic parseModel}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = response.data;
        return parseModel.fromJson(data);
      } catch (e) {
        return parseModel.fromJson({});
      }
    } else {
      return parseModel.fromJson({});
    }
  }

  List<T> handleResponseList<T>(Response response,
      {required dynamic parseModel}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = response.data;
        return List<T>.from(data.map((x) => parseModel.fromJson(x)));
      } catch (e) {
        return parseModel.fromJson({});
      }
    } else {
      return [parseModel.fromJson({})];
    }
  }
}
