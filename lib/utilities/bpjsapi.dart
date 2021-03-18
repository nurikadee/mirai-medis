import 'package:crypto/crypto.dart';
import 'dart:convert';

class BpjsApi {
  void generate() {
    var key = utf8.encode('8nN746B858');
    var bytes = utf8.encode('2818&1615607706');

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    var bytesBase = utf8.encode(digest.toString());

    print(base64.encode(bytesBase));
  }
}
