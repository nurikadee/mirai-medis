import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';

abstract class PendaftaranViewInterface {
  void showMessage(String message, bool error);

  void showDays(InitResponse initResponse);

  void showDebitur(DebiturResponse debiturResponse);

  void showRujukan(RujukanResponse rujukanResponse);

  void showBpjsToPoli(BpjsToPoliResponse bpjsToPoliResponse);

  void showAfterSubmitPendaftaran(PendaftaranResponse pendaftaranResponse);

  void showPoli(PoliResponse poliResponse);
}
