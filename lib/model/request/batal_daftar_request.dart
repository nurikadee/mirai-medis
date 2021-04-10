class BatalDaftarRequest {
  String pendaftaranId;

  BatalDaftarRequest({this.pendaftaranId});

  BatalDaftarRequest.fromJson(Map<String, dynamic> json) {
    if (json["pendaftaran_id"] is String)
      this.pendaftaranId = json["pendaftaran_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["pendaftaran_id"] = this.pendaftaranId;
    return data;
  }
}
