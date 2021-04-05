class LoginResponse {
  int status;
  String message;
  DataUser data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is Map)
      this.data = json["data"] == null ? null : DataUser.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null) data["data"] = this.data.toJson();
    return data;
  }
}

class DataUser {
  User user;
  Pasien pasien;

  DataUser({this.user, this.pasien});

  DataUser.fromJson(Map<String, dynamic> json) {
    if (json["user"] is Map)
      this.user = json["user"] == null ? null : User.fromJson(json["user"]);
    if (json["pasien"] is Map)
      this.pasien =
          json["pasien"] == null ? null : Pasien.fromJson(json["pasien"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.user != null) data["user"] = this.user.toJson();
    if (this.pasien != null) data["pasien"] = this.pasien.toJson();
    return data;
  }
}

class Pasien {
  int pendidikanKode;
  String tempatLahir;
  String tglLahir;
  String alergi;
  String kelurahanKode;
  String kedudukanKeluarga;
  int anakKe;
  int istriKe;
  String goldar;
  String jurusanKode;
  String kode;
  String nama;
  String alamat;
  String noIdentitas;
  String noTelp;
  String jkel;
  String statusKawinKode;
  String tempatKerja;
  String alamatTempatKerja;
  String ayahNama;
  String ibuNama;
  String namaPasangan;
  int agamaKode;
  int pekerjaanKode;
  int jmlAnak;
  String deletedAt;
  String deletedBy;
  int penghasilan;
  int sukuKode;
  int kewarganegaraanKode;
  String rt;
  String rw;
  String createdBy;
  String createdAt;
  String updatedBy;
  String updatedAt;
  String ayahNoRekamMedis;
  String ibuNoRekamMedis;
  String jenisIdentitasKode;

  Pasien(
      {this.pendidikanKode,
      this.tempatLahir,
      this.tglLahir,
      this.alergi,
      this.kelurahanKode,
      this.kedudukanKeluarga,
      this.anakKe,
      this.istriKe,
      this.goldar,
      this.jurusanKode,
      this.kode,
      this.nama,
      this.alamat,
      this.noIdentitas,
      this.noTelp,
      this.jkel,
      this.statusKawinKode,
      this.tempatKerja,
      this.alamatTempatKerja,
      this.ayahNama,
      this.ibuNama,
      this.namaPasangan,
      this.agamaKode,
      this.pekerjaanKode,
      this.jmlAnak,
      this.deletedAt,
      this.deletedBy,
      this.penghasilan,
      this.sukuKode,
      this.kewarganegaraanKode,
      this.rt,
      this.rw,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.ayahNoRekamMedis,
      this.ibuNoRekamMedis,
      this.jenisIdentitasKode});

  Pasien.fromJson(Map<String, dynamic> json) {
    if (json["pendidikan_kode"] is int)
      this.pendidikanKode = json["pendidikan_kode"];
    if (json["tempat_lahir"] is String) this.tempatLahir = json["tempat_lahir"];
    if (json["tgl_lahir"] is String) this.tglLahir = json["tgl_lahir"];
    if (json["alergi"] is String) this.alergi = json["alergi"];
    if (json["kelurahan_kode"] is String)
      this.kelurahanKode = json["kelurahan_kode"];
    if (json["kedudukan_keluarga"] is String)
      this.kedudukanKeluarga = json["kedudukan_keluarga"];
    if (json["anak_ke"] is int) this.anakKe = json["anak_ke"];
    if (json["istri_ke"] is int) this.istriKe = json["istri_ke"];
    if (json["goldar"] is String) this.goldar = json["goldar"];
    if (json["jurusan_kode"] is String) this.jurusanKode = json["jurusan_kode"];
    if (json["kode"] is String) this.kode = json["kode"];
    if (json["nama"] is String) this.nama = json["nama"];
    if (json["alamat"] is String) this.alamat = json["alamat"];
    if (json["no_identitas"] is String) this.noIdentitas = json["no_identitas"];
    if (json["no_telp"] is String) this.noTelp = json["no_telp"];
    if (json["jkel"] is String) this.jkel = json["jkel"];
    if (json["status_kawin_kode"] is String)
      this.statusKawinKode = json["status_kawin_kode"];
    if (json["tempat_kerja"] is String) this.tempatKerja = json["tempat_kerja"];
    if (json["alamat_tempat_kerja"] is String)
      this.alamatTempatKerja = json["alamat_tempat_kerja"];
    if (json["ayah_nama"] is String) this.ayahNama = json["ayah_nama"];
    if (json["ibu_nama"] is String) this.ibuNama = json["ibu_nama"];
    if (json["nama_pasangan"] is String)
      this.namaPasangan = json["nama_pasangan"];
    if (json["agama_kode"] is int) this.agamaKode = json["agama_kode"];
    if (json["pekerjaan_kode"] is int)
      this.pekerjaanKode = json["pekerjaan_kode"];
    if (json["jml_anak"] is int) this.jmlAnak = json["jml_anak"];
    if (json["deleted_at"] is String) this.deletedAt = json["deleted_at"];
    if (json["deleted_by"] is String) this.deletedBy = json["deleted_by"];
    if (json["penghasilan"] is int) this.penghasilan = json["penghasilan"];
    if (json["suku_kode"] is int) this.sukuKode = json["suku_kode"];
    if (json["kewarganegaraan_kode"] is int)
      this.kewarganegaraanKode = json["kewarganegaraan_kode"];
    if (json["rt"] is String) this.rt = json["rt"];
    if (json["rw"] is String) this.rw = json["rw"];
    if (json["created_by"] is String) this.createdBy = json["created_by"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_by"] is String) this.updatedBy = json["updated_by"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["ayah_no_rekam_medis"] is String)
      this.ayahNoRekamMedis = json["ayah_no_rekam_medis"];
    if (json["ibu_no_rekam_medis"] is String)
      this.ibuNoRekamMedis = json["ibu_no_rekam_medis"];
    if (json["jenis_identitas_kode"] is String)
      this.jenisIdentitasKode = json["jenis_identitas_kode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["pendidikan_kode"] = this.pendidikanKode;
    data["tempat_lahir"] = this.tempatLahir;
    data["tgl_lahir"] = this.tglLahir;
    data["alergi"] = this.alergi;
    data["kelurahan_kode"] = this.kelurahanKode;
    data["kedudukan_keluarga"] = this.kedudukanKeluarga;
    data["anak_ke"] = this.anakKe;
    data["istri_ke"] = this.istriKe;
    data["goldar"] = this.goldar;
    data["jurusan_kode"] = this.jurusanKode;
    data["kode"] = this.kode;
    data["nama"] = this.nama;
    data["alamat"] = this.alamat;
    data["no_identitas"] = this.noIdentitas;
    data["no_telp"] = this.noTelp;
    data["jkel"] = this.jkel;
    data["status_kawin_kode"] = this.statusKawinKode;
    data["tempat_kerja"] = this.tempatKerja;
    data["alamat_tempat_kerja"] = this.alamatTempatKerja;
    data["ayah_nama"] = this.ayahNama;
    data["ibu_nama"] = this.ibuNama;
    data["nama_pasangan"] = this.namaPasangan;
    data["agama_kode"] = this.agamaKode;
    data["pekerjaan_kode"] = this.pekerjaanKode;
    data["jml_anak"] = this.jmlAnak;
    data["deleted_at"] = this.deletedAt;
    data["deleted_by"] = this.deletedBy;
    data["penghasilan"] = this.penghasilan;
    data["suku_kode"] = this.sukuKode;
    data["kewarganegaraan_kode"] = this.kewarganegaraanKode;
    data["rt"] = this.rt;
    data["rw"] = this.rw;
    data["created_by"] = this.createdBy;
    data["created_at"] = this.createdAt;
    data["updated_by"] = this.updatedBy;
    data["updated_at"] = this.updatedAt;
    data["ayah_no_rekam_medis"] = this.ayahNoRekamMedis;
    data["ibu_no_rekam_medis"] = this.ibuNoRekamMedis;
    data["jenis_identitas_kode"] = this.jenisIdentitasKode;
    return data;
  }
}

class User {
  int id;
  String noRekamMedis;
  String noIdentitas;
  String tanggalLahir;
  String passwordHash;
  int status;
  String authKey;
  String passwordResetToken;
  String accountActivationToken;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.noRekamMedis,
      this.noIdentitas,
      this.tanggalLahir,
      this.passwordHash,
      this.status,
      this.authKey,
      this.passwordResetToken,
      this.accountActivationToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["no_rekam_medis"] is String)
      this.noRekamMedis = json["no_rekam_medis"];
    if (json["no_identitas"] is String) this.noIdentitas = json["no_identitas"];
    if (json["tanggal_lahir"] is String)
      this.tanggalLahir = json["tanggal_lahir"];
    if (json["password_hash"] is String)
      this.passwordHash = json["password_hash"];
    if (json["status"] is int) this.status = json["status"];
    if (json["auth_key"] is String) this.authKey = json["auth_key"];
    if (json["password_reset_token"] is String)
      this.passwordResetToken = json["password_reset_token"];
    if (json["account_activation_token"] is String)
      this.accountActivationToken = json["account_activation_token"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["no_rekam_medis"] = this.noRekamMedis;
    data["no_identitas"] = this.noIdentitas;
    data["tanggal_lahir"] = this.tanggalLahir;
    data["password_hash"] = this.passwordHash;
    data["status"] = this.status;
    data["auth_key"] = this.authKey;
    data["password_reset_token"] = this.passwordResetToken;
    data["account_activation_token"] = this.accountActivationToken;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
