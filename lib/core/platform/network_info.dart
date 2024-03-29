import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  void onInternetChange({
    required Function() onConnect,
    required Function() onDisconnect,
  }) {}
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  void onInternetChange({
    required Function() onConnect,
    required Function() onDisconnect,
  }) {
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        onConnect();
      } else {
        onDisconnect();
      }
    });
  }
}

class WebNetworkInfoImpl implements NetworkInfo {
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => throw UnimplementedError();

  @override
  void onInternetChange(
      {required Function() onConnect, required Function() onDisconnect}) {
    // TODO: implement onInternetChange
  }
}
