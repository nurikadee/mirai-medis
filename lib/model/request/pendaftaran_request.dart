class PendaftaranRequest {
  String noRekamMedis;
  String poliRsId;
  String poliRsName;
  String tanggalKunjungan;
  String debiturId;
  String debiturName;
  String noKartuBpjs;
  String noRujukanBpjs;

  PendaftaranRequest(
      {this.noRekamMedis,
      this.poliRsId,
      this.poliRsName,
      this.tanggalKunjungan,
      this.debiturId,
      this.debiturName,
      this.noKartuBpjs,
      this.noRujukanBpjs});

  PendaftaranRequest.fromJson(Map<String, dynamic> json) {
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
    if (json["poli_rs_id"] is String) this.poliRsId = json["poli_rs_id"];
    if (json["poli_rs_name"] is String) this.poliRsName = json["poli_rs_name"];
    if (json["tanggal_kunjungan"] is String)
      this.tanggalKunjungan = json["tanggal_kunjungan"];
    if (json["debitur_id"] is String) this.debiturId = json["debitur_id"];
    if (json["debitur_name"] is String) this.debiturName = json["debitur_name"];
    if (json["no_kartu_bpjs"] is String)
      this.noKartuBpjs = json["no_kartu_bpjs"];
    if (json["no_rujukan_bpjs"] is String)
      this.noRujukanBpjs = json["no_rujukan_bpjs"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["no_rekam_medis"] = this.noRekamMedis;
    data["poli_rs_id"] = this.poliRsId;
    data["poli_rs_name"] = this.poliRsName;
    data["tanggal_kunjungan"] = this.tanggalKunjungan;
    data["debitur_id"] = this.debiturId;
    data["debitur_name"] = this.debiturName;
    data["no_kartu_bpjs"] = this.noKartuBpjs ?? "";
    data["no_rujukan_bpjs"] = this.noRujukanBpjs ?? "";
    return data;
  }
}
