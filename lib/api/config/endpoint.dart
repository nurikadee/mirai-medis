import 'apisettings.dart';

class EndpointMedis {
  static var saveToken =
      Uri.parse(APiSettings.baseUrlMedis + "auth/save-token");
  static var login = Uri.parse(APiSettings.baseUrlMedis + "auth/login");
  static var dokter = Uri.parse(APiSettings.baseUrlMedis + "dokter/get-dokter");
}
