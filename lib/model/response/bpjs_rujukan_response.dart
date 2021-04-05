class RujukanResponse {
  int status;
  String message;
  DataRujukan data;

  RujukanResponse({this.status, this.message, this.data});

  RujukanResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is Map)
      this.data =
          json["data"] == null ? null : DataRujukan.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null) data["data"] = this.data.toJson();
    return data;
  }
}

class DataRujukan {
  String asalFaskes;
  Rujukan rujukan;
  List<Rujukan> listRujukan;

  DataRujukan({this.asalFaskes, this.rujukan});

  DataRujukan.fromJson(Map<String, dynamic> json) {
    if (json["asalFaskes"] is String) this.asalFaskes = json["asalFaskes"];

    if (json["rujukan"] is Map) {
      this.rujukan =
          json["rujukan"] == null ? null : Rujukan.fromJson(json["rujukan"]);
    }

    if (json["rujukan"] is List) {
      this.listRujukan = json["rujukan"] == null
          ? []
          : (json["rujukan"] as List).map((e) => Rujukan.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["asalFaskes"] = this.asalFaskes;
    if (this.rujukan != null) {
      if (this.rujukan is Map) {
        data["rujukan"] = this.rujukan.toJson();
      }
      if (this.rujukan is List) {
        data["rujukan"] = this.listRujukan.map((e) => e.toJson()).toList();
      }
    }

    return data;
  }
}

class Rujukan {
  Diagnosa diagnosa;
  String keluhan;
  String noKunjungan;
  Pelayanan pelayanan;
  Peserta peserta;
  PoliRujukan poliRujukan;
  ProvPerujuk provPerujuk;
  String tglKunjungan;

  Rujukan(
      {this.diagnosa,
      this.keluhan,
      this.noKunjungan,
      this.pelayanan,
      this.peserta,
      this.poliRujukan,
      this.provPerujuk,
      this.tglKunjungan});

  Rujukan.fromJson(Map<String, dynamic> json) {
    if (json["diagnosa"] is Map)
      this.diagnosa =
          json["diagnosa"] == null ? null : Diagnosa.fromJson(json["diagnosa"]);
    if (json["keluhan"] is String) this.keluhan = json["keluhan"];
    if (json["noKunjungan"] is String) this.noKunjungan = json["noKunjungan"];
    if (json["pelayanan"] is Map)
      this.pelayanan = json["pelayanan"] == null
          ? null
          : Pelayanan.fromJson(json["pelayanan"]);
    if (json["peserta"] is Map)
      this.peserta =
          json["peserta"] == null ? null : Peserta.fromJson(json["peserta"]);
    if (json["poliRujukan"] is Map)
      this.poliRujukan = json["poliRujukan"] == null
          ? null
          : PoliRujukan.fromJson(json["poliRujukan"]);
    if (json["provPerujuk"] is Map)
      this.provPerujuk = json["provPerujuk"] == null
          ? null
          : ProvPerujuk.fromJson(json["provPerujuk"]);
    if (json["tglKunjungan"] is String)
      this.tglKunjungan = json["tglKunjungan"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.diagnosa != null) data["diagnosa"] = this.diagnosa.toJson();
    data["keluhan"] = this.keluhan;
    data["noKunjungan"] = this.noKunjungan;
    if (this.pelayanan != null) data["pelayanan"] = this.pelayanan.toJson();
    if (this.peserta != null) data["peserta"] = this.peserta.toJson();
    if (this.poliRujukan != null)
      data["poliRujukan"] = this.poliRujukan.toJson();
    if (this.provPerujuk != null)
      data["provPerujuk"] = this.provPerujuk.toJson();
    data["tglKunjungan"] = this.tglKunjungan;
    return data;
  }
}

class ProvPerujuk {
  String kode;
  String nama;

  ProvPerujuk({this.kode, this.nama});

  ProvPerujuk.fromJson(Map<String, dynamic> json) {
    if (json["kode"] is String) this.kode = json["kode"];
    if (json["nama"] is String) this.nama = json["nama"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kode"] = this.kode;
    data["nama"] = this.nama;
    return data;
  }
}

class PoliRujukan {
  String kode;
  String nama;

  PoliRujukan({this.kode, this.nama});

  PoliRujukan.fromJson(Map<String, dynamic> json) {
    if (json["kode"] is String) this.kode = json["kode"];
    if (json["nama"] is String) this.nama = json["nama"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kode"] = this.kode;
    data["nama"] = this.nama;
    return data;
  }
}

class Peserta {
  Cob cob;
  HakKelas hakKelas;
  Informasi informasi;
  JenisPeserta jenisPeserta;
  Mr mr;
  String nama;
  String nik;
  String noKartu;
  String pisa;
  ProvUmum provUmum;
  String sex;
  StatusPeserta statusPeserta;
  String tglCetakKartu;
  String tglLahir;
  String tglTat;
  String tglTmt;
  Umur umur;

  Peserta(
      {this.cob,
      this.hakKelas,
      this.informasi,
      this.jenisPeserta,
      this.mr,
      this.nama,
      this.nik,
      this.noKartu,
      this.pisa,
      this.provUmum,
      this.sex,
      this.statusPeserta,
      this.tglCetakKartu,
      this.tglLahir,
      this.tglTat,
      this.tglTmt,
      this.umur});

  Peserta.fromJson(Map<String, dynamic> json) {
    if (json["cob"] is Map)
      this.cob = json["cob"] == null ? null : Cob.fromJson(json["cob"]);
    if (json["hakKelas"] is Map)
      this.hakKelas =
          json["hakKelas"] == null ? null : HakKelas.fromJson(json["hakKelas"]);
    if (json["informasi"] is Map)
      this.informasi = json["informasi"] == null
          ? null
          : Informasi.fromJson(json["informasi"]);
    if (json["jenisPeserta"] is Map)
      this.jenisPeserta = json["jenisPeserta"] == null
          ? null
          : JenisPeserta.fromJson(json["jenisPeserta"]);
    if (json["mr"] is Map)
      this.mr = json["mr"] == null ? null : Mr.fromJson(json["mr"]);
    if (json["nama"] is String) this.nama = json["nama"];
    if (json["nik"] is String) this.nik = json["nik"];
    if (json["noKartu"] is String) this.noKartu = json["noKartu"];
    if (json["pisa"] is String) this.pisa = json["pisa"];
    if (json["provUmum"] is Map)
      this.provUmum =
          json["provUmum"] == null ? null : ProvUmum.fromJson(json["provUmum"]);
    if (json["sex"] is String) this.sex = json["sex"];
    if (json["statusPeserta"] is Map)
      this.statusPeserta = json["statusPeserta"] == null
          ? null
          : StatusPeserta.fromJson(json["statusPeserta"]);
    if (json["tglCetakKartu"] is String)
      this.tglCetakKartu = json["tglCetakKartu"];
    if (json["tglLahir"] is String) this.tglLahir = json["tglLahir"];
    if (json["tglTAT"] is String) this.tglTat = json["tglTAT"];
    if (json["tglTMT"] is String) this.tglTmt = json["tglTMT"];
    if (json["umur"] is Map)
      this.umur = json["umur"] == null ? null : Umur.fromJson(json["umur"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.cob != null) data["cob"] = this.cob.toJson();
    if (this.hakKelas != null) data["hakKelas"] = this.hakKelas.toJson();
    if (this.informasi != null) data["informasi"] = this.informasi.toJson();
    if (this.jenisPeserta != null)
      data["jenisPeserta"] = this.jenisPeserta.toJson();
    if (this.mr != null) data["mr"] = this.mr.toJson();
    data["nama"] = this.nama;
    data["nik"] = this.nik;
    data["noKartu"] = this.noKartu;
    data["pisa"] = this.pisa;
    if (this.provUmum != null) data["provUmum"] = this.provUmum.toJson();
    data["sex"] = this.sex;
    if (this.statusPeserta != null)
      data["statusPeserta"] = this.statusPeserta.toJson();
    data["tglCetakKartu"] = this.tglCetakKartu;
    data["tglLahir"] = this.tglLahir;
    data["tglTAT"] = this.tglTat;
    data["tglTMT"] = this.tglTmt;
    if (this.umur != null) data["umur"] = this.umur.toJson();
    return data;
  }
}

class Umur {
  String umurSaatPelayanan;
  String umurSekarang;

  Umur({this.umurSaatPelayanan, this.umurSekarang});

  Umur.fromJson(Map<String, dynamic> json) {
    if (json["umurSaatPelayanan"] is String)
      this.umurSaatPelayanan = json["umurSaatPelayanan"];
    if (json["umurSekarang"] is String)
      this.umurSekarang = json["umurSekarang"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["umurSaatPelayanan"] = this.umurSaatPelayanan;
    data["umurSekarang"] = this.umurSekarang;
    return data;
  }
}

class StatusPeserta {
  String keterangan;
  String kode;

  StatusPeserta({this.keterangan, this.kode});

  StatusPeserta.fromJson(Map<String, dynamic> json) {
    if (json["keterangan"] is String) this.keterangan = json["keterangan"];
    if (json["kode"] is String) this.kode = json["kode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["keterangan"] = this.keterangan;
    data["kode"] = this.kode;
    return data;
  }
}

class ProvUmum {
  String kdProvider;
  String nmProvider;

  ProvUmum({this.kdProvider, this.nmProvider});

  ProvUmum.fromJson(Map<String, dynamic> json) {
    if (json["kdProvider"] is String) this.kdProvider = json["kdProvider"];
    if (json["nmProvider"] is String) this.nmProvider = json["nmProvider"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kdProvider"] = this.kdProvider;
    data["nmProvider"] = this.nmProvider;
    return data;
  }
}

class Mr {
  String noMr;
  String noTelepon;

  Mr({this.noMr, this.noTelepon});

  Mr.fromJson(Map<String, dynamic> json) {
    if (json["noMR"] is String) this.noMr = json["noMR"];
    if (json["noTelepon"] is String) this.noTelepon = json["noTelepon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["noMR"] = this.noMr;
    data["noTelepon"] = this.noTelepon;
    return data;
  }
}

class JenisPeserta {
  String keterangan;
  String kode;

  JenisPeserta({this.keterangan, this.kode});

  JenisPeserta.fromJson(Map<String, dynamic> json) {
    if (json["keterangan"] is String) this.keterangan = json["keterangan"];
    if (json["kode"] is String) this.kode = json["kode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["keterangan"] = this.keterangan;
    data["kode"] = this.kode;
    return data;
  }
}

class Informasi {
  String dinsos;
  String noSktm;
  String prolanisPrb;

  Informasi({this.dinsos, this.noSktm, this.prolanisPrb});

  Informasi.fromJson(Map<String, dynamic> json) {
    if (json["dinsos"] is String) this.dinsos = json["dinsos"];
    if (json["noSKTM"] is String) this.noSktm = json["noSKTM"];
    if (json["prolanisPRB"] is String) this.prolanisPrb = json["prolanisPRB"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["dinsos"] = this.dinsos;
    data["noSKTM"] = this.noSktm;
    data["prolanisPRB"] = this.prolanisPrb;
    return data;
  }
}

class HakKelas {
  String keterangan;
  String kode;

  HakKelas({this.keterangan, this.kode});

  HakKelas.fromJson(Map<String, dynamic> json) {
    if (json["keterangan"] is String) this.keterangan = json["keterangan"];
    if (json["kode"] is String) this.kode = json["kode"];
    if (json["kode"] is int) this.kode = json["kode"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["keterangan"] = this.keterangan;
    data["kode"] = this.kode;
    return data;
  }
}

class Cob {
  String nmAsuransi;
  String noAsuransi;
  String tglTat;
  String tglTmt;

  Cob({this.nmAsuransi, this.noAsuransi, this.tglTat, this.tglTmt});

  Cob.fromJson(Map<String, dynamic> json) {
    if (json["nmAsuransi"] is String) this.nmAsuransi = json["nmAsuransi"];
    if (json["noAsuransi"] is String) this.noAsuransi = json["noAsuransi"];
    if (json["tglTAT"] is String) this.tglTat = json["tglTAT"];
    if (json["tglTMT"] is String) this.tglTmt = json["tglTMT"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["nmAsuransi"] = this.nmAsuransi;
    data["noAsuransi"] = this.noAsuransi;
    data["tglTAT"] = this.tglTat;
    data["tglTMT"] = this.tglTmt;
    return data;
  }
}

class Pelayanan {
  String kode;
  String nama;

  Pelayanan({this.kode, this.nama});

  Pelayanan.fromJson(Map<String, dynamic> json) {
    if (json["kode"] is String) this.kode = json["kode"];
    if (json["kode"] is int) this.kode = json["kode"].toString();
    if (json["nama"] is String) this.nama = json["nama"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kode"] = this.kode;
    data["nama"] = this.nama;
    return data;
  }
}

class Diagnosa {
  String kode;
  String nama;

  Diagnosa({this.kode, this.nama});

  Diagnosa.fromJson(Map<String, dynamic> json) {
    if (json["kode"] is String) this.kode = json["kode"];
    if (json["kode"] is int) this.kode = json["kode"].toString();
    if (json["nama"] is String) this.nama = json["nama"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kode"] = this.kode;
    data["nama"] = this.nama;
    return data;
  }
}
