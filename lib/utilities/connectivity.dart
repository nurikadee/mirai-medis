import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class NetworkSettings {
  static StatusConnection statusConnection;
  static Connectivity connectivity = Connectivity();
  static StreamSubscription<ConnectivityResult> connectionSubscription;

  static Future<void> initConnectivity(Connectivity connectivity) async {
    try {
      ConnectivityResult result = await connectivity.checkConnectivity();
      changeStatus(result);
    } on PlatformException catch (e) {
      print(e.toString());
      statusConnection = StatusConnection.none;
    }
  }

  static networkSubscription(
      StreamSubscription<ConnectivityResult> connectionSubscription) {
    connectionSubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      changeStatus(result);
    });
  }

  static changeStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      statusConnection = StatusConnection.none;
    } else if (result == ConnectivityResult.mobile) {
      statusConnection = StatusConnection.mobile;
    } else if (result == ConnectivityResult.wifi) {
      statusConnection = StatusConnection.wifi;
    }
  }

  static void dispose() {
    if (connectionSubscription != null) {
      connectionSubscription.cancel();
    }
  }
}

enum StatusConnection { none, mobile, wifi }
