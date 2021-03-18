import 'dart:async';
import 'dart:io';
import 'package:apimodule/model/response/global_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/utilities/version_checking.dart';
import 'package:medis/view/splash/pattern/splash_presenter.dart';
import 'package:medis/view/splash/pattern/splash_view_interface.dart';
import 'package:medis/view/splash/pattern/splash_view_model.dart';

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
  String versionName = '2.0.0';

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
        packageName = 'com.rsudaa.pelayanananonline';
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
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.green.withOpacity(0.5), BlendMode.softLight),
                  image: AssetImage('assets/images/bgsplash.png'),
                  fit: BoxFit.cover),
            ),
            child: Center(
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
                    SizedBox(height: 50),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      width: MediaQuery.of(this.context).size.width / 3,
                      lineHeight: 2.0,
                      animation: true,
                      percent: 1.0,
                      animationDuration: 2250,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.white,
                    ),
                    SizedBox(height: 100),
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
          ),
        );
      },
      presenter: SplashPresenter(SplashViewModel(), this),
    );
  }

  @override
  void goToHome(GlobalResponse globalResponse) {
    // Timer(Duration(milliseconds: 4500), () {
    //   if (!versionCheck.hasUpdate) {
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (ctx) => BottomBar(),
    //         ));
    //   }
    // });
  }
}
