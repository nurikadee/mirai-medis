class APiSettings {
  static var bearer = "";

  static var header = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": bearer
  };
  static var baseUrlMedis = "http://123.231.247.213/mirai-medis-api/v1/";

  static var errorMsg =
      "Terjadi kesalahan pada server, mohon ulangi beberapa saat lagi";
  static var errorNetwork =
      "Tidak dapat terhubung ke server, periksa kembali jaringan internet anda";
}
