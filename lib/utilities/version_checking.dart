import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

typedef Future<StoreVersionAndUrl> GetStoreVersionAndUrl(String packageName);
typedef void ShowUpdateDialog(BuildContext context, VersionCheck versionCheck);

class StoreVersionAndUrl {
  final String storeVersion;
  final String storeUrl;

  StoreVersionAndUrl(this.storeVersion, this.storeUrl);
}

class VersionCheck {
  String packageName;
  String packageVersion;
  String storeVersion;
  String storeUrl;

  GetStoreVersionAndUrl getStoreVersionAndUrl;
  ShowUpdateDialog showUpdateDialog;

  VersionCheck({
    this.packageName,
    this.packageVersion,
    this.getStoreVersionAndUrl,
    this.showUpdateDialog,
  });

  Future checkVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    packageName ??= packageInfo.packageName;
    packageVersion ??= packageInfo.version;

    if (getStoreVersionAndUrl == null) {
      switch (Platform.operatingSystem) {
        case 'android':
          getStoreVersionAndUrl = _getAndroidStoreVersionAndUrl;
          break;
        case 'ios':
          getStoreVersionAndUrl = _getIOSStoreVersionAndUrl;
          break;
        case 'macos':
          getStoreVersionAndUrl = _getMacStoreVersionAndUrl;
          break;
        default:
          throw "Platform ${Platform.operatingSystem} not supported.";
      }
    }

    final storeVersionAndUrl = await getStoreVersionAndUrl(packageName);
    storeVersion = storeVersionAndUrl.storeVersion;
    storeUrl = storeVersionAndUrl.storeUrl;

    if (hasUpdate) {
      showUpdateDialog ??= _showUpdateDialog;
      showUpdateDialog(context, this);
    }
  }

  get hasUpdate {
    if (packageVersion == null) return false;
    if (storeVersion == null) return false;
    return _shouldUpdate(packageVersion, storeVersion);
  }

  Future launchStore() async {
    final url = storeUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Future<StoreVersionAndUrl> _getIOSStoreVersionAndUrl(String bundleId) async {
  final resp = await http
      .get(Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId'));

  if (resp.statusCode == 200) {
    final j = json.decode(resp.body);
    final version = j['results'][0]['version'];
    final url = j['results'][0]['trackViewUrl'];
    return StoreVersionAndUrl(version, url);
  }

  return null;
}

Future<StoreVersionAndUrl> _getAndroidStoreVersionAndUrl(
    String packageName) async {
  final resp = await http.get(
      Uri.parse(
          'https://play.google.com/store/apps/details?id=$packageName&hl=en'),
      headers: {
        'referer': 'http://www.google.com',
        'user-agent':
            "Mozilla/5.0 (Windows; U; WindowsNT 5.1; en-US; rv1.8.1.6) Gecko/20070725 Firefox/2.0.0.6",
      });

  if (resp.statusCode == 200) {
    final doc = parse(resp.body);
    final url = 'https://play.google.com/store/apps/details?id=$packageName';

    try {
      final elements = doc.querySelectorAll('.hAyfc .BgcNfc');

      final cv =
          elements.firstWhere((element) => element.text == 'Current Version');
      final version = cv.nextElementSibling.text;
      return StoreVersionAndUrl(version, url);
    } catch (_) {}
    try {
      final elements = doc.querySelectorAll('div');

      final cv =
          elements.firstWhere((element) => element.text == 'Current Version');
      final version = cv.nextElementSibling.text;
      return StoreVersionAndUrl(version, url);
    } catch (_) {}
  }

  return null;
}

Future<StoreVersionAndUrl> _getMacStoreVersionAndUrl(String bundleId) async {
  final resp = await http
      .get(Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId'));

  if (resp.statusCode == 200) {
    final j = json.decode(resp.body);
    final version = j['results'][0]['version'];
    final url = j['results'][0]['trackViewUrl'];
    return StoreVersionAndUrl(version, url);
  }

  return null;
}

bool _shouldUpdate(String packageVersion, String storeVersion) {
  if (packageVersion == storeVersion) return false;

  final current = int.parse(packageVersion.replaceAll('.', ''));
  final store = int.parse(storeVersion.replaceAll('.', ''));

  if (store > current) {
    return true;
  } else {
    return false;
  }
}

void _showUpdateDialog(BuildContext context, VersionCheck versionCheck) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Pembaruan Tersedia'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  'Apakah anda ingin memperbaruhi ke versi ${versionCheck.storeVersion}?'),
              Text('(versi saat ini ${versionCheck.packageVersion})'),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            child: Text('Update', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              Navigator.of(context).pop();
              await versionCheck.launchStore();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            child: Text('Close', style: TextStyle(color: Colors.white)),
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ],
      );
    },
  );
}
