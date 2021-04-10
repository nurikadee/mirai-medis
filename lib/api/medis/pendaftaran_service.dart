import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/config/endpoint.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/request/polibpjs_to_poli_request.dart';
import 'package:medis/model/request/rujukan_request.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';

class PendaftaranService {
  static List<RujukanParam> rujukanParam = [
    RujukanParam(type: 1, multi: 1),
    RujukanParam(type: 1, multi: 0),
    RujukanParam(type: 2, multi: 1),
    RujukanParam(type: 2, multi: 0)
  ];

  static Future<dynamic> getInit() async {
    var header;
    await Pref.getUserLogin().then((value) {
      header = APiSettings.getHeader("Bearer ${value.user.authKey}");
    });

    try {
      final response = await http.get(EndpointMedis.init, headers: header);

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.init}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return InitResponse.fromJson(body);
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

  static Future<dynamic> getDebitur() async {
    try {
      final response = await http.get(EndpointMedis.debitur,
          headers: APiSettings.getHeader(null));

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.debitur}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return DebiturResponse.fromJson(body);
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

  static Future<dynamic> getRujukan(
      RujukanRequest request, int rujukanParamIndex) async {
    try {
      var header;
      await Pref.getUserLogin().then((value) {
        header = APiSettings.getHeader("Bearer ${value.user.authKey}");
      });
      request.multi = rujukanParam[rujukanParamIndex].multi.toString();
      request.type = rujukanParam[rujukanParamIndex].type.toString();

      var response = await http.post(EndpointMedis.rujukan,
          headers: header, body: request.toJson());

      developer.log("${request.toJson()}",
          name: "Request $rujukanParamIndex ${EndpointMedis.rujukan}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.rujukan}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return RujukanResponse.fromJson(body);
          break;
        case 400:
          if (rujukanParamIndex < rujukanParam.length - 1) {
            return getRujukan(request, rujukanParamIndex + 1);
          } else {
            return BaseResponse(message: "Nomor Rujukan tidak ditemukan");
          }
          break;
        default:
          return BaseResponse(message: APiSettings.errorMsg);
          break;
      }
    } on SocketException {
      return BaseResponse(message: APiSettings.errorNetwork);
    }
  }

  static Future<dynamic> mappingBpjsToPoli(BpjsToPoliRequest request) async {
    try {
      var header;
      await Pref.getUserLogin().then((value) {
        header = APiSettings.getHeader("Bearer ${value.user.authKey}");
      });

      var response = await http.post(EndpointMedis.bpjstopoli,
          headers: header, body: request.toJson());

      developer.log("${request.toJson()}",
          name: "Request ${EndpointMedis.bpjstopoli}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.bpjstopoli}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return BpjsToPoliResponse.fromJson(body);
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

  static Future<dynamic> getPoli(bool isVip) async {
    try {
      var header;
      await Pref.getUserLogin().then((value) {
        header = APiSettings.getHeader("Bearer ${value.user.authKey}");
      });

      var endpoint = isVip ? EndpointMedis.poliUtama : EndpointMedis.poli;
      var response = await http.get(endpoint, headers: header);

      developer.log("${jsonDecode(response.body)}", name: "Response $endpoint");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return PoliResponse.fromJson(body);
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

  static Future<dynamic> sendToDaftarPoli(PendaftaranRequest request) async {
    try {
      var header;
      await Pref.getUserLogin().then((value) {
        header = APiSettings.getHeader("Bearer ${value.user.authKey}");
      });

      var response = await http.post(EndpointMedis.daftarPoli,
          headers: header, body: request.toJson());

      developer.log("${request.toJson()}",
          name: "Request ${EndpointMedis.daftarPoli}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.daftarPoli}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return PendaftaranResponse.fromJson(body);
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
