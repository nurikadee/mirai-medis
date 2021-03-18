import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/utilities/bpjsapi.dart';
import 'package:medis/utilities/device_info.dart';
import 'package:medis/utilities/utils.dart';
import 'package:medis/view/splash/splash.dart';

import 'cache/pref.dart';

final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
StreamSubscription<Position> positionStreamSubscription;
Position currentPosition;
LatLng center;

class Medis extends StatefulWidget {
  @override
  _MedisState createState() => _MedisState();
}

class _MedisState extends State<Medis> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    setUpFirebase();
    initPlatformState();
    requestLocationPermission();

    var bpjs = BpjsApi();
    bpjs.generate();
  }

  setUpFirebase() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Token Push Notif : $token");
      Pref.setTokenFirebase(token);
    });
  }

  Future<void> initPlatformState() async {
    String id;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo =
            await DeviceInfo.deviceInfoPlugin.androidInfo;
        id = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iOSInfo = await DeviceInfo.deviceInfoPlugin.iosInfo;
        id = iOSInfo.identifierForVendor;
      }
    } on PlatformException {
      id = 'Failed to get platform version.';
    }

    print("Device ID : $id");
    Pref.setDeviceId(id);
  }

  void requestLocationPermission() async {
    Position currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (!mounted) return;

    setState(() {
      currentPosition = currentPosition;
      center = LatLng(currentPosition.latitude, currentPosition.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: EasyLoading.init(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(0.8, 1.1);
            return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            );
          },
        ),
        navigatorObservers: [defaultLifecycleObserver],
        debugShowCheckedModeBanner: false,
        title: 'Mirai Medis',
        theme: Utils.getTheme(),
        home: Splash());
  }
}
