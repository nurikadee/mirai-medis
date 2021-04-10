import 'apisettings.dart';

class EndpointMedis {
  static var saveToken =
      Uri.parse(APiSettings.baseUrlMedis + "auth/save-token");
  static var login = Uri.parse(APiSettings.baseUrlMedis + "auth/login");
  static var dokter = Uri.parse(APiSettings.baseUrlMedis + "dokter/get-dokter");
  static var dokterByPoli =
      Uri.parse(APiSettings.baseUrlMedis + "dokter/get-dokter-by-poli");
  static var jadwalDokter =
      Uri.parse(APiSettings.baseUrlMedis + "dokter/get-jadwal-dokter");
  static var init = Uri.parse(APiSettings.baseUrlMedis + "pendaftaran/init");
  static var debitur =
      Uri.parse(APiSettings.baseUrlMedis + "debitur/get-debitur");
  static var rujukan =
      Uri.parse(APiSettings.baseUrlMedis + "bpjs/rujukan/get-rujukan-by-kartu");
  static var bpjstopoli =
      Uri.parse(APiSettings.baseUrlMedis + "poli/get-poli-rs-by-poli-bpjs");
  static var daftarPoli =
      Uri.parse(APiSettings.baseUrlMedis + "pendaftaran/daftar-poli");
  static var poli = Uri.parse(APiSettings.baseUrlMedis + "poli/get-poli");
  static var poliUtama =
      Uri.parse(APiSettings.baseUrlMedis + "poli/get-poli-utama");
  static var listKamar =
      Uri.parse(APiSettings.baseUrlMedis + "info-kamar/kamar-rawat-inap");
  static var activity = Uri.parse(APiSettings.baseUrlMedis + "riwayat/pasien");
}
