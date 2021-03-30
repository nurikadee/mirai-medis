class JadwalDokterResponse {
  int status;
  String message;
  List<JadwalDokter> data;

  JadwalDokterResponse({this.status, this.message, this.data});

  JadwalDokterResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? []
          : (json["data"] as List)
              .map((e) => JadwalDokter.fromJson(e))
              .toList();
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

class JadwalDokter {
  DokterDetail dokter;
  int unitKode;
  int pegawaiId;
  String tanggal;
  List<JadwalPraktik> jadwalPraktik;

  JadwalDokter(
      {this.dokter,
      this.unitKode,
      this.pegawaiId,
      this.tanggal,
      this.jadwalPraktik});

  JadwalDokter.fromJson(Map<String, dynamic> json) {
    if (json["dokter"] is Map)
      this.dokter =
          json["dokter"] == null ? null : DokterDetail.fromJson(json["dokter"]);
    if (json["unit_kode"] is int) this.unitKode = json["unit_kode"];
    if (json["pegawai_id"] is int) this.pegawaiId = json["pegawai_id"];
    if (json["tanggal"] is String) this.tanggal = json["tanggal"];
    if (json["jadwal_praktik"] is List)
      this.jadwalPraktik = json["jadwal_praktik"] == null
          ? []
          : (json["jadwal_praktik"] as List)
              .map((e) => JadwalPraktik.fromJson(e))
              .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.dokter != null) data["dokter"] = this.dokter.toJson();
    data["unit_kode"] = this.unitKode;
    data["pegawai_id"] = this.pegawaiId;
    data["tanggal"] = this.tanggal;
    if (this.jadwalPraktik != null)
      data["jadwal_praktik"] =
          this.jadwalPraktik.map((e) => e.toJson()).toList();
    return data;
  }
}

class JadwalPraktik {
  String jam;
  String keterangan;
  int statusDatang;

  JadwalPraktik({this.jam, this.keterangan, this.statusDatang});

  JadwalPraktik.fromJson(Map<String, dynamic> json) {
    if (json["jam"] is String) this.jam = json["jam"];
    if (json["keterangan"] is String) this.keterangan = json["keterangan"];
    if (json["status_datang"] is int) this.statusDatang = json["status_datang"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["jam"] = this.jam;
    data["keterangan"] = this.keterangan;
    data["status_datang"] = this.statusDatang;
    return data;
  }
}

class DokterDetail {
  String idNipNrp;
  String namaLengkap;
  String gelarSarjanaDepan;
  String gelarSarjanaBelakang;

  DokterDetail(
      {this.idNipNrp,
      this.namaLengkap,
      this.gelarSarjanaDepan,
      this.gelarSarjanaBelakang});

  DokterDetail.fromJson(Map<String, dynamic> json) {
    if (json["id_nip_nrp"] is String) this.idNipNrp = json["id_nip_nrp"];
    if (json["nama_lengkap"] is String) this.namaLengkap = json["nama_lengkap"];
    if (json["gelar_sarjana_depan"] is String)
      this.gelarSarjanaDepan = json["gelar_sarjana_depan"];
    if (json["gelar_sarjana_belakang"] is String)
      this.gelarSarjanaBelakang = json["gelar_sarjana_belakang"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id_nip_nrp"] = this.idNipNrp;
    data["nama_lengkap"] = this.namaLengkap;
    data["gelar_sarjana_depan"] = this.gelarSarjanaDepan;
    data["gelar_sarjana_belakang"] = this.gelarSarjanaBelakang;
    return data;
  }
}
