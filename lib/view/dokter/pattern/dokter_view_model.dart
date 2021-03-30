import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class DokterViewModel extends MVVMModel {
  BaseResponse baseResponse;

  DokterResponse dokterResponse;

  DokterByPoliResponse dokterByPoliResponse;

  JadwalDokterResponse jadwalDokterResponse;
}
