class PendaftaranRequest {
  int id;
  String noRekamMedis;
  String poliRsId;
  String tanggalKunjungan;
  String tanggalPendaftaran;
  String debiturId;
  int statucCetakTracer;
  int statusDistribusi;
  int statusPembatalan;
  int noAntrian;
  String noKartuBpjs;
  String noRujukanBpjs;
  int idControlSimrs;
  String note;
  String kodeBookingAntrianMobileJkn;
  String createdAt;
  String updatedAt;

  PendaftaranRequest(
      {this.id,
      this.noRekamMedis,
      this.poliRsId,
      this.tanggalKunjungan,
      this.tanggalPendaftaran,
      this.debiturId,
      this.statucCetakTracer,
      this.statusDistribusi,
      this.statusPembatalan,
      this.noAntrian,
      this.noKartuBpjs,
      this.noRujukanBpjs,
      this.idControlSimrs,
      this.note,
      this.kodeBookingAntrianMobileJkn,
      this.createdAt,
      this.updatedAt});

  PendaftaranRequest.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
    if (json["poli_rs_id"] is String) this.poliRsId = json["poli_rs_id"];
    if (json["tanggal_kunjungan"] is String)
      this.tanggalKunjungan = json["tanggal_kunjungan"];
    if (json["tanggal_pendaftaran"] is String)
      this.tanggalPendaftaran = json["tanggal_pendaftaran"];
    if (json["debitur_id"] is String) this.debiturId = json["debitur_id"];
    if (json["statuc_cetak_tracer"] is int)
      this.statucCetakTracer = json["statuc_cetak_tracer"];
    if (json["status_distribusi"] is int)
      this.statusDistribusi = json["status_distribusi"];
    if (json["status_pembatalan"] is int)
      this.statusPembatalan = json["status_pembatalan"];
    if (json["no_antrian"] is int) this.noAntrian = json["no_antrian"];
    if (json["no_kartu_bpjs"] is String)
      this.noKartuBpjs = json["no_kartu_bpjs"];
    if (json["no_rujukan_bpjs"] is String)
      this.noRujukanBpjs = json["no_rujukan_bpjs"];
    if (json["id_control_simrs"] is int)
      this.idControlSimrs = json["id_control_simrs"];
    if (json["note"] is String) this.note = json["note"];
    if (json["kode_booking_antrian_mobile_jkn"] is String)
      this.kodeBookingAntrianMobileJkn =
          json["kode_booking_antrian_mobile_jkn"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["no_rekam_medis"] = this.noRekamMedis;
    data["poli_rs_id"] = this.poliRsId;
    data["tanggal_kunjungan"] = this.tanggalKunjungan;
    data["tanggal_pendaftaran"] = this.tanggalPendaftaran;
    data["debitur_id"] = this.debiturId;
    data["statuc_cetak_tracer"] = this.statucCetakTracer;
    data["status_distribusi"] = this.statusDistribusi;
    data["status_pembatalan"] = this.statusPembatalan;
    data["no_antrian"] = this.noAntrian;
    data["no_kartu_bpjs"] = this.noKartuBpjs;
    data["no_rujukan_bpjs"] = this.noRujukanBpjs;
    data["id_control_simrs"] = this.idControlSimrs;
    data["note"] = this.note;
    data["kode_booking_antrian_mobile_jkn"] = this.kodeBookingAntrianMobileJkn;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
