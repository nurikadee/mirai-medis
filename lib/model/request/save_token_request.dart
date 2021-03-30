class SaveTokenRequest {
  String noRekamMedis;
  String deviceId;
  String token;

  SaveTokenRequest({this.noRekamMedis, this.deviceId, this.token});

  SaveTokenRequest.fromJson(Map<String, dynamic> json) {
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
    if (json["device_id"] is String) this.deviceId = json["device_id"];
    if (json["token"] is String) this.token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["no_rekam_medis"] = this.noRekamMedis;
    data["device_id"] = this.deviceId;
    data["token"] = this.token;
    return data;
  }
}
