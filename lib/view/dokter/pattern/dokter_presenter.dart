import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/medis/dokter_service.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/view/dokter/pattern/dokter_view_interface.dart';
import 'package:medis/view/dokter/pattern/dokter_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class DokterPresenter extends Presenter<DokterViewModel, DokterViewInterface> {
  DokterPresenter(DokterViewModel model, DokterViewInterface view)
      : super(model, view);

  @override
  Future onInit() async {
    getListDokter();
    this.refreshView();
  }

  Future<void> getListDokter() async {
    EasyLoading.show(status: 'Loading...');

    await DokterService.getListDokter().then((value) {
      if (value is DokterResponse) {
        if (value.status == 200) {
          this.viewModel.dokterResponse = value;
          this.viewInterface.showListDokter(value);
        }
      } else if (value is BaseResponse) {
        viewInterface.showMessage(APiSettings.errorNetwork, true);
      } else {
        viewInterface.showMessage(value.message, true);
      }

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }
}
