import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/config/endpoint.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/request/rekam_medis_request.dart';
import 'package:medis/model/response/activity_response.dart';
import 'package:medis/model/response/base_response.dart';

class ActivityService {
  static Future<dynamic> getActivity() async {
    RekamMedisRequest request = RekamMedisRequest();
    var header;
    await Pref.getUserLogin().then((value) {
      header = APiSettings.getHeader("Bearer ${value.user.authKey}");
      request.noRekamMedis = value.user.noRekamMedis;
    });

    try {
      final response = await http.post(EndpointMedis.activity,
          headers: header, body: request.toJson());

      developer.log("${request.toJson()}",
          name: "Request ${EndpointMedis.activity}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.activity}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return ActivityResponse.fromJson(body);
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
