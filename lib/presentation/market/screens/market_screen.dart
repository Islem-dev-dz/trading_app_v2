import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/core/providers/user_status_provider.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userStatus = ref.watch(userStatusProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marché Boursier'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_card),
              onPressed: () {
                if (userStatus.kycStatus == KycStatus.pending) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez compléter votre identité d\'abord.')),
                  );
                } else if (userStatus.bankStatus == BankStatus.notLinked) {
                  context.push('/bank-link');
                } else {
                  context.push('/manage-accounts');
                }
              },
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Marché Primaire'),
              Tab(text: 'Marché Secondaire'),
            ],
          ),
        ),
        body: Column(
          children: [
            if (userStatus.kycStatus == KycStatus.pending)
              MaterialBanner(
                padding: const EdgeInsets.all(16),
                content: const Text(
                  'Veuillez compléter votre identité pour débloquer toutes les fonctionnalités.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: theme.colorScheme.error,
                actions: [
                  TextButton(
                    onPressed: () {
                      context.push('/kyc');
                    },
                    child: const Text('Compléter', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              color: theme.colorScheme.secondary.withValues(alpha: 0.1),
              child: Row(
                children: [
                  Icon(Icons.calendar_month, color: theme.colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text(
                    'Prochaine Séance: 30 Avril 2026',
                    style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.secondary),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _PrimaryMarketView(userStatus: userStatus),
                  _SecondaryMarketView(userStatus: userStatus),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryMarketView extends StatelessWidget {
  final UserStatus userStatus;
  
  const _PrimaryMarketView({required this.userStatus});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMarketCard(
          context,
          title: 'BADR Emission 2026',
          isin: 'DZ000000001',
          price: '1000.00',
          volume: '50,000',
        ),
      ],
    );
  }

  Widget _buildMarketCard(BuildContext context, {required String title, required String isin, required String price, required String volume}) {
    final theme = Theme.of(context);
    final isLinked = userStatus.bankStatus == BankStatus.linked;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLinked ? () {
          context.push('/market-detail', extra: {
            'title': title,
            'isin': isin,
            'price': price,
          });
        } : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title, 
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isLinked ? null : Colors.grey,
                      )
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isLinked ? theme.colorScheme.primary.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Nouveau', style: TextStyle(color: isLinked ? theme.colorScheme.primary : Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('ISIN: $isin', style: theme.textTheme.bodyMedium?.copyWith(color: isLinked ? null : Colors.grey)),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prix d\'émission', style: theme.textTheme.bodyMedium?.copyWith(color: isLinked ? null : Colors.grey)),
                      Text('$price DZD', style: theme.textTheme.titleLarge?.copyWith(color: isLinked ? theme.colorScheme.primary : Colors.grey)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Volume disponible', style: theme.textTheme.bodyMedium?.copyWith(color: isLinked ? null : Colors.grey)),
                      Text(volume, style: TextStyle(fontWeight: FontWeight.bold, color: isLinked ? null : Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryMarketView extends StatelessWidget {
  final UserStatus userStatus;
  
  const _SecondaryMarketView({required this.userStatus});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOfferCard(
          context,
          title: 'Sonatrach Actions',
          isin: 'DZ000000002',
          price: '2150.00',
          volume: '150',
          type: 'sell', // original type from UI perspective
        ),
        _buildOfferCard(
          context,
          title: 'Cevital Obligations',
          isin: 'DZ000000003',
          price: '500.00',
          volume: '1000',
          type: 'buy', // original type from UI perspective
        ),
      ],
    );
  }

  Widget _buildOfferCard(BuildContext context, {required String title, required String isin, required String price, required String volume, required String type}) {
    final theme = Theme.of(context);
    final isLinked = userStatus.bankStatus == BankStatus.linked;
    final isSellOffer = type == 'sell';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLinked ? () {
          context.push('/market-detail', extra: {
            'title': title,
            'isin': isin,
            'price': price,
          });
        } : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title, 
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isLinked ? null : Colors.grey,
                      )
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isLinked ? (isSellOffer ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1)) : Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(isSellOffer ? 'Vente' : 'Achat', style: TextStyle(color: isLinked ? (isSellOffer ? Colors.red : Colors.green) : Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('ISIN: $isin', style: theme.textTheme.bodyMedium?.copyWith(color: isLinked ? null : Colors.grey)),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prix unitaire', style: theme.textTheme.bodyMedium?.copyWith(color: isLinked ? null : Colors.grey)),
                      Text('$price DZD', style: theme.textTheme.titleLarge?.copyWith(color: isLinked ? null : Colors.grey)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Quantité', style: theme.textTheme.bodyMedium?.copyWith(color: isLinked ? null : Colors.grey)),
                      Text(volume, style: TextStyle(fontWeight: FontWeight.bold, color: isLinked ? null : Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
