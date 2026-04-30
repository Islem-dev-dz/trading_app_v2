import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Portefeuille'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _showProfileBottomSheet(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Valorisation Globale', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              '1,750,000.00 DZD',
              style: theme.textTheme.displayMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const Text('Mes Comptes BADR', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildAccountCard(
              context,
              type: 'Compte Espèce',
              id: 'ACC-ESP-01',
              balance: '500,000.00 DZD',
              icon: Icons.account_balance_wallet,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildAccountCard(
              context,
              type: 'Compte Titre',
              id: 'ACC-TIT-01',
              balance: '1,250,000.00 DZD',
              icon: Icons.show_chart,
              color: theme.colorScheme.secondary,
            ),
            const SizedBox(height: 32),
            const Text('Répartition des Titres', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Placeholder for fl_chart or list
            const Card(
              child: ListTile(
                title: Text('BADR Emission 2026'),
                subtitle: Text('100 Unités'),
                trailing: Text('100,000.00 DZD'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Sonatrach Actions'),
                subtitle: Text('500 Unités'),
                trailing: Text('1,150,000.00 DZD'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context, {required String type, required String id, required String balance, required IconData icon, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(id, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Text(balance, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                const SizedBox(height: 16),
                const Text('Investisseur BADR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('USR-9988', style: TextStyle(color: Colors.grey)),
                const Divider(height: 32),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Modifier le profil'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Supprimer mon compte', style: TextStyle(color: Colors.red)),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Se déconnecter'),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
