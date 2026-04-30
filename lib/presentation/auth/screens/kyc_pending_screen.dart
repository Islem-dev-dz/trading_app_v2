import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycPendingScreen extends StatelessWidget {
  const KycPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  size: 100,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Dossier en cours d\'examen',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Vos informations KYC et bancaires ont bien été soumises. Un agent BADR vérifie actuellement votre dossier.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    // In a real app, you would poll the server or rely on a push notification.
                    // Here we just simulate an approval.
                    context.go('/market');
                  },
                  child: const Text('Simuler l\'approbation -> Accéder au Marché'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Retour à la connexion'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
