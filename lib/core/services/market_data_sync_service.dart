import 'dart:async';
import 'package:flutter/material.dart';

class MarketDataSyncService {
  Timer? _timer;
  
  // Trading days in Algiers Stock Exchange (Sun: 7, Tue: 2, Thu: 4)
  final List<int> _tradingDays = [DateTime.sunday, DateTime.tuesday, DateTime.thursday];

  void startPeriodicSync(BuildContext context) {
    // Check every minute if we need to sync (for demo, you'd check less frequently in prod or use background fetch)
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAndSync(context);
    });
    
    // Check immediately on start
    _checkAndSync(context);
  }

  void _checkAndSync(BuildContext context) {
    final now = DateTime.now();
    
    // Check if today is a trading day
    if (_tradingDays.contains(now.weekday)) {
      // Check if time is past 11:00 AM (end of session in Algiers)
      if (now.hour >= 11) {
        _simulateScrapingAndSync(context);
      }
    }
  }

  void _simulateScrapingAndSync(BuildContext context) {
    // In a real app, we would make an HTTP request to scrape data or call an API,
    // parse the XML/JSON, and update the local database/cache.
    
    debugPrint('Simulation: Scraping Bourse d\'Alger data... Time is past 11:00 on a trading day.');
    
    // For demonstration, we just show a notification that data was synced
    // if the user is in the app. In background, it would just save to local DB.
    
    /* Uncomment to show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Synchronisation des données de marché terminée (Post-séance).'),
        duration: Duration(seconds: 2),
      ),
    );
    */
  }

  void stopSync() {
    _timer?.cancel();
  }
}
