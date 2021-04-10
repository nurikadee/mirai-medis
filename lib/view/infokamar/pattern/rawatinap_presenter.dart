import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/medis/rawatinap_service.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/info_kamar_rawat_response.dart';
import 'package:medis/view/infokamar/pattern/rawatinap_view_interface.dart';
import 'package:medis/view/infokamar/pattern/rawatinap_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class RawatInapPresenter
    extends Presenter<RawatInapViewModel, RawatInapViewInterface> {
  RawatInapPage page;

  RawatInapPresenter(
      RawatInapViewModel model, RawatInapViewInterface view, RawatInapPage page)
      : super(model, view) {
    this.page = page;
  }

  @override
  Future onInit() async {
    switch (this.page) {
      case RawatInapPage.INFO_KAMAR:
        getListInfoKamar();
        break;
    }
    this.refreshView();
  }

  Future<void> getListInfoKamar() async {
    EasyLoading.show(status: 'Loading...');

    await RawatInapService.getListInfoKamar().then((value) {
      if (value is InfoKamarRawatResponse) {
        if (value.status == 200) {
          this.viewModel.infoKamarRawatResponse = value;
          this.viewInterface.showListKamar(value);
        }
      } else if (value is BaseResponse) {
        viewInterface.showMessage(value.message, true);
      } else {
        viewInterface.showMessage(APiSettings.errorMsg, true);
      }

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }
}

enum RawatInapPage { INFO_KAMAR }
