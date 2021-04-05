import 'package:medis/model/response/debitur_response.dart';

class InitResponse {
  int status;
  String message;
  InitData data;

  InitResponse({this.status, this.message, this.data});

  InitResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is Map)
      this.data = json["data"] == null ? null : InitData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null) data["data"] = this.data.toJson();
    return data;
  }
}

class InitData {
  List<String> weekdays;
  List<Debitur> debitur;

  InitData({this.weekdays, this.debitur});

  InitData.fromJson(Map<String, dynamic> json) {
    if (json["weekdays"] is List)
      this.weekdays = json["weekdays"]?.cast<String>() ?? [];
    if (json["debitur"] is List)
      this.debitur = json["debitur"] == null
          ? []
          : (json["debitur"] as List).map((e) => Debitur.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.weekdays != null) data["weekdays"] = this.weekdays;
    if (this.debitur != null)
      data["debitur"] = this.debitur.map((e) => e.toJson()).toList();
    return data;
  }
}
