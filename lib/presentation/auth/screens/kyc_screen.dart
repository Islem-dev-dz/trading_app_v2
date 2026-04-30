import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/core/providers/user_status_provider.dart';

class KycScreen extends ConsumerWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vérification d\'identité (KYC)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Renseignez vos informations personnelles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom complet'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Numéro de carte d\'identité / Passeport'),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                // Mock document upload
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document scanné avec succès')));
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Téléverser un document d\'identité'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ref.read(userStatusProvider.notifier).submitKyc();
                context.go('/market');
              },
              child: const Text('Soumettre et continuer'),
            ),
          ],
        ),
      ),
    );
  }
}
