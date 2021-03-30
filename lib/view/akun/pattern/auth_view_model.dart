import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/login_response.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class AuthViewModel extends MVVMModel {
  BaseResponse baseResponse;

  LoginResponse loginResponse;
}
