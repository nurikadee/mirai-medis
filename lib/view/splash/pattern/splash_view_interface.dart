import 'package:medis/model/response/base_response.dart';

abstract class SplashViewInterface {
  void showMessage(String message, bool error);

  void goToHome(BaseResponse baseResponse);
}
