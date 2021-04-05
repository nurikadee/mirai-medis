class BpjsToPoliRequest {
  String poliBpjsId;

  BpjsToPoliRequest({this.poliBpjsId});

  BpjsToPoliRequest.fromJson(Map<String, dynamic> json) {
    if (json["poli_bpjs_id"] is String) this.poliBpjsId = json["poli_bpjs_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["poli_bpjs_id"] = this.poliBpjsId;
    return data;
  }
}
