import 'package:medis/model/response/login_response.dart';

abstract class AuthViewInterface {
  void saveAccount(LoginResponse loginResponse);

  void showMessage(String message, bool error);
}
