import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/config/endpoint.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/info_kamar_rawat_response.dart';

class RawatInapService {
  static Future<dynamic> getListInfoKamar() async {
    var header;
    await Pref.getUserLogin().then((value) {
      header = APiSettings.getHeader("Bearer ${value.user.authKey}");
    });

    try {
      final response = await http.get(EndpointMedis.listKamar, headers: header);

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.listKamar}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return InfoKamarRawatResponse.fromJson(body);
          break;
        case 400:
          final body = jsonDecode(response.body);
          return BaseResponse.fromJson(body);
          break;
        default:
          return BaseResponse(message: APiSettings.errorMsg);
          break;
      }
    } on SocketException {
      return BaseResponse(message: APiSettings.errorNetwork);
    }
  }
}
