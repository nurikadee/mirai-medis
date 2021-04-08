import 'package:medis/model/response/polibpjs_to_poli_response.dart';

class PoliResponse {
  int status;
  String message;
  List<PoliRs> data;

  PoliResponse({this.status, this.message, this.data});

  PoliResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? []
          : (json["data"] as List).map((e) => PoliRs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null)
      data["data"] = this.data.map((e) => e.toJson()).toList();
    return data;
  }
}
