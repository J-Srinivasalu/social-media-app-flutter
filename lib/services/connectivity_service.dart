import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:social_media_app/utils/enums.dart';

class ConnectivityService {
  final StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  void setConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatusController(result);
    });
  }

  void updateConnectionStatusController(ConnectivityResult result) {
    var connectionStatus = _getStatusFromResult(result);

    connectionStatusController.add(connectionStatus);
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.CELLULAR;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WIFI;
      case ConnectivityResult.none:
        return ConnectivityStatus.OFFLINE;
      default:
        return ConnectivityStatus.OFFLINE;
    }
  }
}
