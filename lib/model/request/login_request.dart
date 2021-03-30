class LoginRequest {
  String username;
  String tanggalLahir;
  String password;

  LoginRequest({this.username, this.tanggalLahir, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    if (json["username"] is String) this.username = json["username"];
    if (json["tanggal_lahir"] is String)
      this.tanggalLahir = json["tanggal_lahir"];
    if (json["password"] is String) this.password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["username"] = this.username;
    data["tanggal_lahir"] = this.tanggalLahir;
    data["password"] = this.password;
    return data;
  }
}
