import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';

abstract class DokterViewInterface {
  void showMessage(String message, bool error);

  void showListDokter(DokterResponse dokterResponse);

  void showListDokterByPoli(DokterByPoliResponse dokterByPoliResponse);

  void showListJadwalDokter(JadwalDokterResponse jadwalDokterResponse);
}
