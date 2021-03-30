import 'package:medis/api/medis/auth_service.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/request/save_token_request.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/view/splash/pattern/splash_view_interface.dart';
import 'package:medis/view/splash/pattern/splash_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class SplashPresenter extends Presenter<SplashViewModel, SplashViewInterface> {
  SplashPresenter(SplashViewModel model, SplashViewInterface view)
      : super(model, view);

  @override
  Future onInit() async {
    saveToken();
    refreshView();
  }

  Future<void> saveToken() async {
    var noRekamMedis = "0";
    await Pref.checkIsLoggedIn().then((value) async {
      if (value) {
        noRekamMedis =
            await Pref.getUserLogin().then((value) => value.user.noRekamMedis);
      }
    });
    try {
      var deviceId = await Pref.getDeviceId().then((value) => value);
      var token = await Pref.getTokenFirebase().then((value) => value);

      var request = SaveTokenRequest(
          deviceId: deviceId, noRekamMedis: noRekamMedis, token: token);

      await AuthService.saveToken(request).then((value) {
        viewModel.baseResponse = value;
        viewInterface.goToHome(value);
      });
    } catch (e) {
      viewInterface.goToHome(BaseResponse());
    }
  }
}
