import 'package:medis/model/response/base_response.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class PendaftaranViewModel extends MVVMModel {
  BaseResponse baseResponse;

  InitResponse daysResponse;

  DebiturResponse debiturResponse;

  RujukanResponse rujukanResponse;

  BpjsToPoliResponse bpjsToPoliResponse;
}
