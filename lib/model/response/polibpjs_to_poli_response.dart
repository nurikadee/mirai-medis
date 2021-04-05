class BpjsToPoliResponse {
  int status;
  String message;
  Data data;

  BpjsToPoliResponse({this.status, this.message, this.data});

  BpjsToPoliResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is Map)
      this.data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null) data["data"] = this.data.toJson();
    return data;
  }
}

class Data {
  String poliBpjsId;
  String poliBpjsNama;
  List<PoliRs> poliRs;

  Data({this.poliBpjsId, this.poliBpjsNama, this.poliRs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["poli_bpjs_id"] is String) this.poliBpjsId = json["poli_bpjs_id"];
    if (json["poli_bpjs_nama"] is String)
      this.poliBpjsNama = json["poli_bpjs_nama"];
    if (json["poli_rs"] is List)
      this.poliRs = json["poli_rs"] == null
          ? []
          : (json["poli_rs"] as List).map((e) => PoliRs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["poli_bpjs_id"] = this.poliBpjsId;
    data["poli_bpjs_nama"] = this.poliBpjsNama;
    if (this.poliRs != null)
      data["poli_rs"] = this.poliRs.map((e) => e.toJson()).toList();
    return data;
  }
}

class PoliRs {
  String poliRsId;
  String poliRsNama;

  PoliRs({this.poliRsId, this.poliRsNama});

  PoliRs.fromJson(Map<String, dynamic> json) {
    if (json["poli_rs_id"] is String) this.poliRsId = json["poli_rs_id"];
    if (json["poli_rs_nama"] is String) this.poliRsNama = json["poli_rs_nama"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["poli_rs_id"] = this.poliRsId;
    data["poli_rs_nama"] = this.poliRsNama;
    return data;
  }
}
