class JadwalDokterRequest {
  String idDokter;

  JadwalDokterRequest({this.idDokter});

  JadwalDokterRequest.fromJson(Map<String, dynamic> json) {
    if (json["id_dokter"] is String) this.idDokter = json["id_dokter"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id_dokter"] = this.idDokter;
    return data;
  }
}
