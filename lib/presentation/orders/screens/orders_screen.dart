import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mes Ordres'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'En Cours'),
              Tab(text: 'Exécutés'),
              Tab(text: 'Historique'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ActiveOrdersView(),
            _ExecutedOrdersView(),
            _HistoryOrdersView(),
          ],
        ),
      ),
    );
  }
}

class _ActiveOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Achat - Sonatrach', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                      child: const Text('En attente', style: TextStyle(color: Colors.orange)),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Quantité: 50 | Prix cible: 2150.00 DZD'),
                const Text('Valable jusqu\'au: 30 Mai 2026'),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(onPressed: (){}, icon: const Icon(Icons.cancel, color: Colors.red), label: const Text('Annuler', style: TextStyle(color: Colors.red))),
                    TextButton.icon(onPressed: (){}, icon: const Icon(Icons.refresh), label: const Text('Renouveler')),
                    TextButton.icon(onPressed: (){}, icon: const Icon(Icons.delete_outline), label: const Text('Abandonner')),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ExecutedOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.check, color: Colors.white)),
          title: Text('Souscription BADR 2026'),
          subtitle: Text('Exécuté le 25 Avril 2026'),
          trailing: Text('100 Unités\n100,000 DZD', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}

class _HistoryOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.history, color: Colors.white)),
          title: Text('Vente - Cevital'),
          subtitle: Text('Annulé par l\'utilisateur - 20 Avril 2026'),
          trailing: Text('20 Unités'),
        )
      ],
    );
  }
}
