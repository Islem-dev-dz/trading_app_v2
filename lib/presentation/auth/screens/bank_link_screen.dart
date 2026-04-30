import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/core/providers/user_status_provider.dart';

class BankLinkScreen extends ConsumerStatefulWidget {
  const BankLinkScreen({super.key});

  @override
  ConsumerState<BankLinkScreen> createState() => _BankLinkScreenState();
}

class _BankLinkScreenState extends ConsumerState<BankLinkScreen> {
  String? _selectedAccountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liaison Bancaire')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Liez votre compte BADR',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'RIB (20 chiffres)', prefixIcon: Icon(Icons.account_balance_wallet)),
            ),
            const SizedBox(height: 24),
            const Text('Type de compte à créer', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedAccountType,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'titre', child: Text('Compte Titre')),
                DropdownMenuItem(value: 'espece', child: Text('Compte Espèce')),
                DropdownMenuItem(value: 'mixte', child: Text('Compte Mixte (Titre-Espèce)')),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedAccountType = val;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ref.read(userStatusProvider.notifier).linkBank();
                context.go('/market');
              },
              child: const Text('Lier le compte'),
            ),
          ],
        ),
      ),
    );
  }
}
