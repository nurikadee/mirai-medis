import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/view/home/bottombar.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/utilities/version_checking.dart';
import 'package:medis/view/splash/pattern/splash_presenter.dart';
import 'package:medis/view/splash/pattern/splash_view_interface.dart';
import 'package:medis/view/splash/pattern/splash_view_model.dart';

String versionName = '2.0.0';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> implements SplashViewInterface {
  var isLoggedIn = false;
  var customShowUpdateDialog;
  VersionCheck versionCheck;

  String version = '';
  String storeVersion = '';
  String storeUrl = '';
  String packageName = '';

  @override
  void initState() {
    super.initState();

    checkVersion();
    checkIsLoggedIn();
  }

  Future checkVersion() async {
    try {
      if (Platform.isAndroid) {
        packageName = 'com.rsudaa.pelayanananonline';
      } else if (Platform.isIOS) {
        packageName = 'com.rsudaa.pelayananonline';
      }
    } on PlatformException {}

    versionCheck = VersionCheck(
      packageName: packageName,
      packageVersion: versionName,
    );

    await versionCheck.checkVersion(context);
    setState(() {
      version = versionCheck.packageVersion;
      packageName = versionCheck.packageName;
      storeVersion = versionCheck.storeVersion;
      storeUrl = versionCheck.storeUrl;
    });
  }

  void checkIsLoggedIn() {
    Pref.checkIsLoggedIn().then((seen) => {
          if (seen)
            {
              setState(() {
                isLoggedIn = true;
              })
            }
          else
            {
              setState(() {
                isLoggedIn = false;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MVVMPage<SplashPresenter, SplashViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/bgsplash.png', fit: BoxFit.cover),
              ClipRRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    alignment: Alignment.center),
              )),
              Center(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'MIRAI MEDIS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'QuickSand',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Mobile Information System \nof RSUD Arifin Achmad Pekanbaru',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'QuickSand',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 50),
                      Expanded(
                        child: Container(
                            child: Image.asset(
                          'assets/images/logorsudaa.png',
                          width: 150,
                          height: 150,
                        )),
                      ),
                      SizedBox(height: 150),
                      Text(
                        'version. $versionName',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      presenter: SplashPresenter(SplashViewModel(), this),
    );
  }

  @override
  void goToHome(BaseResponse baseResponse) {
    print(baseResponse.message);
    Timer(Duration(milliseconds: 1500), () {
      if (!versionCheck.hasUpdate) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => BottomBar(),
            ));
      }
    });
  }
}
