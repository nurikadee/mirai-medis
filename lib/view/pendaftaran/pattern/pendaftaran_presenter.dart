import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/medis/pendaftaran_service.dart';
import 'package:medis/model/request/polibpjs_to_poli_request.dart';
import 'package:medis/model/request/rujukan_request.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class PendaftaranPresenter
    extends Presenter<PendaftaranViewModel, PendaftaranViewInterface> {
  PendaftaranPage page;
  String poliBpjsId;

  PendaftaranPresenter(PendaftaranViewModel model,
      PendaftaranViewInterface view, PendaftaranPage page, String poliBpjsId)
      : super(model, view) {
    this.page = page;
    this.poliBpjsId = poliBpjsId;
  }

  @override
  Future onInit() async {
    switch (this.page) {
      case PendaftaranPage.PENDAFTARAN:
        getInit();
        break;
      case PendaftaranPage.UMUM:
        //getDebitur();
        break;
      case PendaftaranPage.BPJS:
        break;
      case PendaftaranPage.POLI:
        mappingBpjsToPoli(BpjsToPoliRequest(poliBpjsId: poliBpjsId));
        break;
    }
    this.refreshView();
  }

  Future<void> getInit() async {
    EasyLoading.show(status: 'Loading...');

    await PendaftaranService.getInit().then((value) {
      if (value is InitResponse) {
        if (value.status == 200) {
          this.viewModel.daysResponse = value;
          this.viewInterface.showDays(value);
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

  Future<void> getRujukan(RujukanRequest request) async {
    EasyLoading.show(status: 'Loading...');

    await PendaftaranService.getRujukan(request, 0).then((value) {
      if (value is RujukanResponse) {
        if (value.status == 200) {
          this.viewModel.rujukanResponse = value;
          this.viewInterface.showRujukan(value);
        }
      } else if (value is BaseResponse) {
        viewInterface.showMessage(APiSettings.errorNetwork, true);
      } else {
        viewInterface.showMessage("", true);
      }

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }

  Future<void> mappingBpjsToPoli(BpjsToPoliRequest request) async {
    EasyLoading.show(status: 'Loading...');

    await PendaftaranService.mappingBpjsToPoli(request).then((value) {
      if (value is BpjsToPoliResponse) {
        if (value.status == 200) {
          this.viewModel.bpjsToPoliResponse = value;
          this.viewInterface.showBpjsToPoli(value);
        }
      } else if (value is BaseResponse) {
        viewInterface.showMessage(APiSettings.errorNetwork, true);
      } else {
        viewInterface.showMessage("", true);
      }

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }
}

enum PendaftaranPage { PENDAFTARAN, UMUM, BPJS, POLI }
