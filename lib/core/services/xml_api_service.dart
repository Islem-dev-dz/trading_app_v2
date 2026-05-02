import 'package:xml/xml.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class XmlApiService {
  /// Simule une requête API ou lit le fichier local
  Future<String> sendRequest(String endpoint) async {
    // Simulation du délai réseau pour la barre de chargement
    await Future.delayed(const Duration(seconds: 1));
    
    debugPrint('--- Requête vers : $endpoint ---');

    // On lit directement ton fichier XML local pour le marché
    if (endpoint.contains('/market')) {
      try {
        return await rootBundle.loadString('assets/data/badr_cotations.xml');
      } catch (e) {
        debugPrint("Erreur lors de la lecture du fichier : $e");
        return _errorResponse("Fichier XML introuvable");
      }
    }

    // Garde tes mocks existants pour les autres fonctions (Auth, Portfolio)
    if (endpoint == '/auth/login') return _mockLoginResponse();
    
    return _errorResponse("Endpoint inconnu");
  }

  String _errorResponse(String message) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
    <response><status>error</status><message>$message</message></response>''';
  }

  String _mockLoginResponse() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('response', nest: () {
      builder.element('status', nest: 'success');
      builder.element('token', nest: 'mock_jwt_token_123');
    });
    return builder.buildDocument().toString();
  }
}