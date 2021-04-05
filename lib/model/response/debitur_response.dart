class DebiturResponse {
  int status;
  String message;
  List<Debitur> data;

  DebiturResponse({this.status, this.message, this.data});

  DebiturResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is int) this.status = json["status"];
    if (json["message"] is String) this.message = json["message"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? []
          : (json["data"] as List).map((e) => Debitur.fromJson(e)).toList();
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

class Debitur {
  String kodeDebitur;
  String namaDebitur;
  List<DebiturDetail> detail;

  Debitur({this.kodeDebitur, this.namaDebitur, this.detail});

  Debitur.fromJson(Map<String, dynamic> json) {
    if (json["kode_debitur"] is String) this.kodeDebitur = json["kode_debitur"];
    if (json["nama_debitur"] is String) this.namaDebitur = json["nama_debitur"];
    if (json["detail"] is List)
      this.detail = json["detail"] == null
          ? []
          : (json["detail"] as List)
              .map((e) => DebiturDetail.fromJson(e))
              .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kode_debitur"] = this.kodeDebitur;
    data["nama_debitur"] = this.namaDebitur;
    if (this.detail != null)
      data["detail"] = this.detail.map((e) => e.toJson()).toList();
    return data;
  }
}

class DebiturDetail {
  String kodeDebiturDetail;
  String namaDebiturDetail;

  DebiturDetail({this.kodeDebiturDetail, this.namaDebiturDetail});

  DebiturDetail.fromJson(Map<String, dynamic> json) {
    if (json["kode_debitur_detail"] is String)
      this.kodeDebiturDetail = json["kode_debitur_detail"];
    if (json["nama_debitur_detail"] is String)
      this.namaDebiturDetail = json["nama_debitur_detail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["kode_debitur_detail"] = this.kodeDebiturDetail;
    data["nama_debitur_detail"] = this.namaDebiturDetail;
    return data;
  }
}
