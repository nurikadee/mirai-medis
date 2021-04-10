class RekamMedisRequest {
  String noRekamMedis;

  RekamMedisRequest({this.noRekamMedis});

  RekamMedisRequest.fromJson(Map<String, dynamic> json) {
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["no_rekam_medis"] = this.noRekamMedis;
    return data;
  }
}
