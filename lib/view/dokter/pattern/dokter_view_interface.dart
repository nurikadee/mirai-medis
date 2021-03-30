import 'package:medis/model/response/dokter_response.dart';

abstract class DokterViewInterface {
  void showMessage(String message, bool error);

  void showListDokter(DokterResponse dokterResponse);
}
