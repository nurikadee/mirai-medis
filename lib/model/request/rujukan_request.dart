class RujukanRequest {
  String nomor;
  String type;
  String multi;

  RujukanRequest({this.nomor, this.type, this.multi});

  RujukanRequest.fromJson(Map<String, dynamic> json) {
    if (json["nomor"] is String) this.nomor = json["nomor"];
    if (json["type"] is String) this.type = json["type"];
    if (json["multi"] is String) this.multi = json["multi"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["nomor"] = this.nomor;
    data["type"] = this.type;
    data["multi"] = this.multi;
    return data;
  }
}

class RujukanParam {
  int type;
  int multi;

  RujukanParam({this.type, this.multi});
}
