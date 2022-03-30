import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

enum RequestMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

abstract class IRestApiRequest {
  String endPoint = "/";
  bool authorize = false;
  Map<String, dynamic> queryParameters = {};
  Map<String, dynamic> body = {};
  RequestMethod requestMethod = RequestMethod.GET;

  Future<void> handleRequest(Response response) async {}
}

class RestApiRequest {
  RestApiRequest({
    this.endPoint = "/",
    this.authorize = false,
    this.body = const {},
    this.queryParameters = const {},
    this.requestMethod = RequestMethod.GET,
  });
  String endPoint;
  bool authorize;
  Map<String, dynamic> queryParameters;
  Map<String, dynamic> body;
  RequestMethod requestMethod;
}
