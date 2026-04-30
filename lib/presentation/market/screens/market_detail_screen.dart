import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_app/core/providers/portfolio_provider.dart';
import 'package:trading_app/core/providers/user_status_provider.dart';
import 'package:trading_app/presentation/market/widgets/market_chart.dart';

class MarketDetailScreen extends ConsumerWidget {
  final String title;
  final String isin;
  final String currentPrice;

  const MarketDetailScreen({
    super.key,
    required this.title,
    required this.isin,
    required this.currentPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final portfolio = ref.watch(portfolioProvider);
    final userStatus = ref.watch(userStatusProvider);

    final int quantityOwned = portfolio.getQuantity(isin);
    final bool canSell = quantityOwned > 0;
    final bool canBuy = userStatus.bankStatus == BankStatus.linked;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Info
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('ISIN: $isin', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey)),
            const SizedBox(height: 24),
            
            // Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dernier cours', style: TextStyle(color: Colors.grey)),
                    Text('$currentPrice DZD', style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('+2.5%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Chart (3 points per week, step logic)
            const SizedBox(
              height: 250,
              child: MarketChart(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cotations: Dimanche, Mardi, Jeudi. Le prix est maintenu fixe entre les séances.',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Portfolio Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.secondary.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Quantité détenue : ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$quantityOwned', style: theme.textTheme.titleLarge),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    onPressed: canBuy ? () {
                      // Demo Buy Action: increment portfolio for testing purposes
                      ref.read(portfolioProvider.notifier).updateQuantity(isin, 10);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Achat effectué avec succès. (+10)')),
                      );
                    } : null,
                    child: const Text('Acheter', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    onPressed: canSell ? () {
                      // Demo Sell Action
                      ref.read(portfolioProvider.notifier).updateQuantity(isin, -10);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vente effectuée avec succès. (-10)')),
                      );
                    } : null,
                    child: const Text('Vendre', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
