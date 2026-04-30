import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptoUtils {
  /// Mocks a hash function for passwords
  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Mocks a digital signature for an order
  static String signOrder(String orderXml) {
    // In a real app, you would use a private key to sign the payload.
    // For this mock, we just hash the payload to create a "signature".
    var bytes = utf8.encode(orderXml);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
