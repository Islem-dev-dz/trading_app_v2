import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trading_app/models/titre_model.dart';
import 'xml_api_service.dart';
import 'package:xml/xml.dart';

class MarketDataSyncService {
  Timer? _timer;
  final XmlApiService _apiService = XmlApiService();
  
  // Jours de cotation à la Bourse d'Alger
  final List<int> _tradingDays = [DateTime.sunday, DateTime.tuesday, DateTime.thursday];

  // --- LOGIQUE DE RÉCUPÉRATION DES DONNÉES (Pour l'UI) ---

  /// Récupère les titres depuis le XML et les filtre par type
  Future<List<TitreBoursier>> getMarketData(String type) async {
    try {
      // Appelle le service XML que nous avons configuré
      final String xmlString = await _apiService.sendRequest('/market/data');
      
      final document = XmlDocument.parse(xmlString);
      final titresXml = document.findAllElements('titre');

      return titresXml
          .where((node) => node.getAttribute('type') == type)
          .map((node) {
        return TitreBoursier(
          libelle: node.findElements('libelle').first.innerText,
          code: node.findElements('code').first.innerText,
          prix: double.parse(node.findElements('prix_actuel').first.innerText),
          variation: node.findElements('variation').first.innerText,
          categorie: node.findElements('categorie').first.innerText,
          type: node.getAttribute('type') ?? 'secondaire',
        );
      }).toList();
    } catch (e) {
      debugPrint("Erreur SyncService: $e");
      return [];
    }
  }

  // --- LOGIQUE DE SYNCHRONISATION TEMPORELLE (Ton code existant) ---

  void startPeriodicSync(BuildContext context) {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAndSync(context);
    });
    _checkAndSync(context);
  }

  void _checkAndSync(BuildContext context) {
    final now = DateTime.now();
    
    // Vérifie si c'est un jour de bourse en Algérie
    if (_tradingDays.contains(now.weekday)) {
      // Fin de séance à 11:00
      if (now.hour >= 11) {
        _simulateScrapingAndSync(context);
      }
    }
  }

  void _simulateScrapingAndSync(BuildContext context) {
    debugPrint('SNTF/BADR Sync: Mise à jour des titres après 11:00...');
    // Ici, on pourrait forcer un rafraîchissement global du cache si nécessaire
  }

  void stopSync() {
    _timer?.cancel();
  }
}