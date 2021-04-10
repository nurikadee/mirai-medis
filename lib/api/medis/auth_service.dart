import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/config/endpoint.dart';
import 'package:medis/model/request/login_request.dart';
import 'package:medis/model/request/save_token_request.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/login_response.dart';

class AuthService {
  static Future<dynamic> saveToken(SaveTokenRequest request) async {
    try {
      final response = await http.post(
        EndpointMedis.saveToken,
        headers: APiSettings.getHeader(null),
        body: request.toJson(),
      );

      developer.log("${request.toJson()}",
          name: "Request ${EndpointMedis.saveToken}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.saveToken}");

      switch (response.statusCode) {
        case 200:
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

  static Future<dynamic> fetchLogin(LoginRequest request) async {
    try {
      final response = await http.post(
        EndpointMedis.login,
        headers: APiSettings.getHeader(null),
        body: request.toJson(),
      );

      developer.log("${request.toJson()}",
          name: "Request ${EndpointMedis.login}");

      developer.log("${jsonDecode(response.body)}",
          name: "Response ${EndpointMedis.login}");

      switch (response.statusCode) {
        case 200:
          final body = jsonDecode(response.body);
          return LoginResponse.fromJson(body);
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
