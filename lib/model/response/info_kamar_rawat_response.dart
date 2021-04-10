class InfoKamarRawatResponse {
  int status;
  String message;
  List<Kelas> data;

  InfoKamarRawatResponse({this.status, this.message, this.data});

  InfoKamarRawatResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? []
          : (json["data"] as List).map((e) => Kelas.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null)
      data["data"] = this.data.map((e) => e.toJson()).toList();
    return data;
  }
}

class Kelas {
  String kodeKelas;
  String namaKelas;
  List<Ruangan> ruangan;

  Kelas({this.kodeKelas, this.namaKelas, this.ruangan});

  Kelas.fromJson(Map<String, dynamic> json) {
    if (json["kode_kelas"] is String) this.kodeKelas = json["kode_kelas"];
    if (json["nama_kelas"] is String) this.namaKelas = json["nama_kelas"];
    if (json["ruangan"] is List)
      this.ruangan = json["ruangan"] == null
          ? []
          : (json["ruangan"] as List).map((e) => Ruangan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["kode_kelas"] = this.kodeKelas;
    data["nama_kelas"] = this.namaKelas;
    if (this.ruangan != null)
      data["data"] = this.ruangan.map((e) => e.toJson()).toList();
    return data;
  }
}

class Ruangan {
  int kodeRuang;
  String namaRuang;
  List<Kamar> kamar;

  Ruangan({this.kodeRuang, this.namaRuang, this.kamar});

  Ruangan.fromJson(Map<String, dynamic> json) {
    if (json["kode_ruang"] is int) this.kodeRuang = json["kode_ruang"];
    if (json["nama_ruang"] is String) this.namaRuang = json["nama_ruang"];
    if (json["kamar"] is List)
      this.kamar = json["kamar"] == null
          ? []
          : (json["kamar"] as List).map((e) => Kamar.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["kode_ruang"] = this.kodeRuang;
    data["nama_ruang"] = this.namaRuang;
    if (this.kamar != null)
      data["kamar"] = this.kamar.map((e) => e.toJson()).toList();
    return data;
  }
}

class Kamar {
  int kamarId;
  String noKamar;
  String noKasur;
  bool available;
  String lastUpdated;

  Kamar(
      {this.kamarId,
      this.noKamar,
      this.noKasur,
      this.available,
      this.lastUpdated});

  Kamar.fromJson(Map<String, dynamic> json) {
    if (json["kamar_id"] is int) this.kamarId = json["kamar_id"];
    if (json["no_kamar"] is String) this.noKamar = json["no_kamar"];
    if (json["no_kasur"] is String) this.noKasur = json["no_kasur"];
    if (json["available"] is bool) this.available = json["available"];
    if (json["last_updated"] is String) this.lastUpdated = json["last_updated"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["kamar_id"] = this.kamarId;
    data["no_kamar"] = this.noKamar;
    data["no_kasur"] = this.noKasur;
    data["available"] = this.available;
    data["last_updated"] = this.lastUpdated;
    return data;
  }
}
