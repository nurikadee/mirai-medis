import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/medis/dokter_service.dart';
import 'package:medis/model/request/jadwal_dokter_request.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';
import 'package:medis/view/dokter/pattern/dokter_view_interface.dart';
import 'package:medis/view/dokter/pattern/dokter_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class DokterPresenter extends Presenter<DokterViewModel, DokterViewInterface> {
  DokterPage page;
  String dokterId;

  DokterPresenter(DokterViewModel model, DokterViewInterface view,
      DokterPage page, String dokterId)
      : super(model, view) {
    this.page = page;
    this.dokterId = dokterId;
  }

  @override
  Future onInit() async {
    switch (this.page) {
      case DokterPage.DOKTER:
        getListDokter();
        break;
      case DokterPage.JADWAL_PRAKTIK:
        getListDokterByPoli();
        break;
      case DokterPage.JADWAL_DOKTER:
        getListJadwalDokter(JadwalDokterRequest(idDokter: this.dokterId));
        break;
    }
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
        viewInterface.showMessage(value.message, true);
      } else {
        viewInterface.showMessage(APiSettings.errorMsg, true);
      }

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }

  Future<void> getListDokterByPoli() async {
    EasyLoading.show(status: 'Loading...');

    await DokterService.getListDokterByPoli().then((value) {
      if (value is DokterByPoliResponse) {
        if (value.status == 200) {
          this.viewModel.dokterByPoliResponse = value;
          this.viewInterface.showListDokterByPoli(value);
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

  Future<void> getListJadwalDokter(JadwalDokterRequest request) async {
    EasyLoading.show(status: 'Loading...');

    await DokterService.getListJadwalDokter(request).then((value) {
      if (value is JadwalDokterResponse) {
        if (value.status == 200) {
          this.viewModel.jadwalDokterResponse = value;
          this.viewInterface.showListJadwalDokter(value);
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

enum DokterPage { DOKTER, JADWAL_PRAKTIK, JADWAL_DOKTER }
