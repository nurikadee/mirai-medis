class DokterResponse {
  int status;
  String message;
  List<PenempatanDokter> data;

  DokterResponse({this.status, this.message, this.data});

  DokterResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? []
          : (json["data"] as List)
              .map((e) => PenempatanDokter.fromJson(e))
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

class PenempatanDokter {
  int unitKerja;
  String nama;
  List<Dokter> dokter;

  PenempatanDokter({this.unitKerja, this.nama, this.dokter});

  PenempatanDokter.fromJson(Map<String, dynamic> json) {
    if (json["unit_kerja"] is int) this.unitKerja = json["unit_kerja"];
    if (json["nama"] is String) this.nama = json["nama"];
    if (json["dokter"] is List)
      this.dokter = json["dokter"] == null
          ? []
          : (json["dokter"] as List).map((e) => Dokter.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["unit_kerja"] = this.unitKerja;
    data["nama"] = this.nama;
    if (this.dokter != null)
      data["dokter"] = this.dokter.map((e) => e.toJson()).toList();
    return data;
  }
}

class Dokter {
  int pegawaiId;
  String idNipNrp;
  String gelarSarjanaDepan;
  String namaLengkap;
  String gelarSarjanaBelakang;
  int unitKerja;
  String nama;
  int sdmRumpun;
  int sdmJenis;

  Dokter(
      {this.pegawaiId,
      this.idNipNrp,
      this.gelarSarjanaDepan,
      this.namaLengkap,
      this.gelarSarjanaBelakang,
      this.unitKerja,
      this.nama,
      this.sdmRumpun,
      this.sdmJenis});

  Dokter.fromJson(Map<String, dynamic> json) {
    if (json["pegawai_id"] is int) this.pegawaiId = json["pegawai_id"];
    if (json["id_nip_nrp"] is String) this.idNipNrp = json["id_nip_nrp"];
    if (json["gelar_sarjana_depan"] is String)
      this.gelarSarjanaDepan = json["gelar_sarjana_depan"];
    if (json["nama_lengkap"] is String) this.namaLengkap = json["nama_lengkap"];
    if (json["gelar_sarjana_belakang"] is String)
      this.gelarSarjanaBelakang = json["gelar_sarjana_belakang"];
    if (json["unit_kerja"] is int) this.unitKerja = json["unit_kerja"];
    if (json["nama"] is String) this.nama = json["nama"];
    if (json["sdm_rumpun"] is int) this.sdmRumpun = json["sdm_rumpun"];
    if (json["sdm_jenis"] is int) this.sdmJenis = json["sdm_jenis"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["pegawai_id"] = this.pegawaiId;
    data["id_nip_nrp"] = this.idNipNrp;
    data["gelar_sarjana_depan"] = this.gelarSarjanaDepan;
    data["nama_lengkap"] = this.namaLengkap;
    data["gelar_sarjana_belakang"] = this.gelarSarjanaBelakang;
    data["unit_kerja"] = this.unitKerja;
    data["nama"] = this.nama;
    data["sdm_rumpun"] = this.sdmRumpun;
    data["sdm_jenis"] = this.sdmJenis;
    return data;
  }
}
