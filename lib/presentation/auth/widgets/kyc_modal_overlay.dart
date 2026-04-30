import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycModalOverlay extends StatelessWidget {
  const KycModalOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified_user_outlined,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Vérification d\'identité',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pour accéder à toutes les fonctionnalités de trading, veuillez soumettre vos documents KYC (Know Your Customer).',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pop(); // Close modal
                  context.go('/kyc'); // Navigate to KYC
                },
                child: const Text('Remplir maintenant'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.pop(); // Close modal
                  context.go('/market'); // Skip to dashboard
                },
                child: const Text('Passer (Plus tard)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showKycModal(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const KycModalOverlay(),
  );
}
