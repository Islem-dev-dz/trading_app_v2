import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_app/core/router/app_router.dart';
import 'package:trading_app/core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BadrTradingApp(),
    ),
  );
}

class BadrTradingApp extends StatelessWidget {
  const BadrTradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BADR Invest',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
