import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/config/endpoint.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/dokter_response.dart';

class DokterService {
  static Future<dynamic> getListDokter() async {
    try {
      final response =
          await http.get(EndpointMedis.dokter, headers: APiSettings.header);

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.dokter}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return DokterResponse.fromJson(body);
      } else {
        return BaseResponse(message: APiSettings.errorMsg);
      }
    } on SocketException {
      return BaseResponse(message: APiSettings.errorNetwork);
    }
  }
}
