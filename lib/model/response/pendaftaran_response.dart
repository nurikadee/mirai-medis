class PendaftaranResponse {
  int status;
  String message;
  Data data;

  PendaftaranResponse({this.status, this.message, this.data});

  PendaftaranResponse.fromJson(Map<String, dynamic> json) {
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
  int pendaftaranId;
  String noRekamMedis;
  String tanggalKunjungan;
  String tanggalPendaftaran;
  int statusPembatalan;
  String note;
  String kodeDebitur;
  String namaDebitur;
  int idAntrian;
  String nomorAntrian;
  int poliRsId;
  String poliRsNama;

  Data(
      {this.pendaftaranId,
      this.noRekamMedis,
      this.tanggalKunjungan,
      this.tanggalPendaftaran,
      this.statusPembatalan,
      this.note,
      this.kodeDebitur,
      this.namaDebitur,
      this.idAntrian,
      this.nomorAntrian,
      this.poliRsId,
      this.poliRsNama});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["pendaftaran_id"] is int)
      this.pendaftaranId = json["pendaftaran_id"];
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
    if (json["tanggal_kunjungan"] is String)
      this.tanggalKunjungan = json["tanggal_kunjungan"];
    if (json["tanggal_pendaftaran"] is String)
      this.tanggalPendaftaran = json["tanggal_pendaftaran"];
    if (json["status_pembatalan"] is int)
      this.statusPembatalan = json["status_pembatalan"];
    if (json["note"] is String) this.note = json["note"];
    if (json["kode_debitur"] is String) this.kodeDebitur = json["kode_debitur"];
    if (json["nama_debitur"] is String) this.namaDebitur = json["nama_debitur"];
    if (json["id_antrian"] is int) this.idAntrian = json["id_antrian"];
    if (json["nomor_antrian"] is String)
      this.nomorAntrian = json["nomor_antrian"];
    if (json["poli_rs_id"] is int) this.poliRsId = json["poli_rs_id"];
    if (json["poli_rs_nama"] is String) this.poliRsNama = json["poli_rs_nama"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["pendaftaran_id"] = this.pendaftaranId;
    data["no_rekam_medis"] = this.noRekamMedis;
    data["tanggal_kunjungan"] = this.tanggalKunjungan;
    data["tanggal_pendaftaran"] = this.tanggalPendaftaran;
    data["status_pembatalan"] = this.statusPembatalan;
    data["note"] = this.note;
    data["kode_debitur"] = this.kodeDebitur;
    data["nama_debitur"] = this.namaDebitur;
    data["id_antrian"] = this.idAntrian;
    data["nomor_antrian"] = this.nomorAntrian;
    data["poli_rs_id"] = this.poliRsId;
    data["poli_rs_nama"] = this.poliRsNama;
    return data;
  }
}
