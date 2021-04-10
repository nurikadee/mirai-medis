class ActivityResponse {
  int status;
  String message;
  List<Activity> data;

  ActivityResponse({this.status, this.message, this.data});

  ActivityResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? []
          : (json["data"] as List).map((e) => Activity.fromJson(e)).toList();
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

class Activity {
  String pendaftaranId;
  String noRekamMedis;
  String tanggalKunjungan;
  String tanggalPendaftaran;
  int statusPembatalan;
  String kodeDebitur;
  String namaDebitur;
  int poliRsId;
  String poliRsNama;
  bool layananWeb;

  Activity(
      {this.pendaftaranId,
      this.noRekamMedis,
      this.tanggalKunjungan,
      this.tanggalPendaftaran,
      this.statusPembatalan,
      this.kodeDebitur,
      this.namaDebitur,
      this.poliRsId,
      this.poliRsNama,
      this.layananWeb});

  Activity.fromJson(Map<String, dynamic> json) {
    if (json["pendaftaran_id"] is String)
      this.pendaftaranId = json["pendaftaran_id"];
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
    if (json["tanggal_kunjungan"] is String)
      this.tanggalKunjungan = json["tanggal_kunjungan"];
    if (json["tanggal_pendaftaran"] is String)
      this.tanggalPendaftaran = json["tanggal_pendaftaran"];
    if (json["status_pembatalan"] is int)
      this.statusPembatalan = json["status_pembatalan"];
    if (json["kode_debitur"] is String) this.kodeDebitur = json["kode_debitur"];
    if (json["nama_debitur"] is String) this.namaDebitur = json["nama_debitur"];
    if (json["poli_rs_id"] is int) this.poliRsId = json["poli_rs_id"];
    if (json["poli_rs_nama"] is String) this.poliRsNama = json["poli_rs_nama"];
    if (json["layanan_web"] is bool) this.layananWeb = json["layanan_web"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["pendaftaran_id"] = this.pendaftaranId;
    data["no_rekam_medis"] = this.noRekamMedis;
    data["tanggal_kunjungan"] = this.tanggalKunjungan;
    data["tanggal_pendaftaran"] = this.tanggalPendaftaran;
    data["status_pembatalan"] = this.statusPembatalan;
    data["kode_debitur"] = this.kodeDebitur;
    data["nama_debitur"] = this.namaDebitur;
    data["poli_rs_id"] = this.poliRsId;
    data["poli_rs_nama"] = this.poliRsNama;
    data["layanan_web"] = this.layananWeb;
    return data;
  }
}
