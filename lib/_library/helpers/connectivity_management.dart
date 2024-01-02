import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef NetworkCallBack = void Function(NetworkResult result);

abstract class INetworkChangeManager {
  Future<NetworkResult> checkNetworkFirstTime();
  void handleNetworkChange(NetworkCallBack onChange);
  void dispose();
}

class NetworkChangeManager extends INetworkChangeManager {
  late final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;

  NetworkChangeManager() {
    _connectivity = Connectivity();
  }

  @override
  Future<NetworkResult> checkNetworkFirstTime() async {
    final connectivityResult = await (_connectivity.checkConnectivity());
    return NetworkResultExtension.checkConnectivityResult(connectivityResult);
  }

  @override
  void handleNetworkChange(NetworkCallBack onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      onChange.call(NetworkResultExtension.checkConnectivityResult(event));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}

enum NetworkResult { on, off }

extension NetworkResultExtension on ConnectivityResult {
  static NetworkResult checkConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
        return NetworkResult.on;
      case ConnectivityResult.none:
        return NetworkResult.off;
    }
  }
}
