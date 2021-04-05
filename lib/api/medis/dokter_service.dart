import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/config/endpoint.dart';
import 'package:medis/model/request/jadwal_dokter_request.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';

class DokterService {
  static Future<dynamic> getListDokter() async {
    try {
      final response = await http.get(EndpointMedis.dokter,
          headers: APiSettings.getHeader(null));

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

  static Future<dynamic> getListDokterByPoli() async {
    try {
      final response = await http.get(EndpointMedis.dokterByPoli,
          headers: APiSettings.getHeader(null));

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.dokterByPoli}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return DokterByPoliResponse.fromJson(body);
      } else {
        return BaseResponse(message: APiSettings.errorMsg);
      }
    } on SocketException {
      return BaseResponse(message: APiSettings.errorNetwork);
    }
  }

  static Future<dynamic> getListJadwalDokter(
      JadwalDokterRequest request) async {
    try {
      final response = await http.post(EndpointMedis.jadwalDokter,
          headers: APiSettings.getHeader(null), body: request.toJson());

      developer.log("${request.toJson()}",
          name: "Request ${EndpointMedis.jadwalDokter}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.jadwalDokter}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return JadwalDokterResponse.fromJson(body);
      } else {
        return BaseResponse(message: APiSettings.errorMsg);
      }
    } on SocketException {
      return BaseResponse(message: APiSettings.errorNetwork);
    }
  }
}
