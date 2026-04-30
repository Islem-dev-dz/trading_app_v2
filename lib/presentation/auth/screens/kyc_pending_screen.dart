import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycPendingScreen extends StatelessWidget {
  const KycPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, primaryColor.withValues(alpha: 0.1)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icône de traitement (Animation possible ici plus tard)
                  Icon(Icons.hourglass_empty_rounded,
                      size: 80, color: Colors.orangeAccent),
                  const SizedBox(height: 24),
                  Text(
                    'Vérification en cours',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nos équipes vérifient vos documents. Cette étape prend généralement moins de 24 heures.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  // Bouton pour aller à l'accueil en attendant
                  ElevatedButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Accéder à l\'accueil'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
