import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/connectivity_service.dart';
import 'package:social_media_app/utils/enums.dart';

import 'no_internet_view.dart';

class ConnectionAwareWidget extends StatelessWidget {
  final Widget child;

  const ConnectionAwareWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (Platform.isIOS) {
      Connectivity().checkConnectivity().then((value) {
        locator<ConnectivityService>().updateConnectionStatusController(value);
      });
    }

    if (connectionStatus == ConnectivityStatus.WIFI ||
        connectionStatus == ConnectivityStatus.CELLULAR) {
      return child;
    }

    return const NoInternetView();
  }
}
