import 'package:medis/model/response/info_kamar_rawat_response.dart';

abstract class RawatInapViewInterface {
  void showMessage(String message, bool error);

  void showListKamar(InfoKamarRawatResponse infoKamarRawatResponse);
}
