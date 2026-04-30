import 'package:flutter_riverpod/legacy.dart';

class PortfolioState {
  // Map of ISIN to quantity owned
  final Map<String, int> holdings;

  const PortfolioState({this.holdings = const {}});

  PortfolioState copyWith({Map<String, int>? holdings}) {
    return PortfolioState(holdings: holdings ?? this.holdings);
  }

  int getQuantity(String isin) {
    return holdings[isin] ?? 0;
  }
}

class PortfolioNotifier extends StateNotifier<PortfolioState> {
  PortfolioNotifier() : super(const PortfolioState(holdings: {
    // For demonstration, let's say the user owns some 'Sonatrach Actions' (DZ000000002) initially
    // 'DZ000000002': 50,
  }));

  void updateQuantity(String isin, int quantityDelta) {
    final currentQty = state.getQuantity(isin);
    final newQty = currentQty + quantityDelta;
    
    if (newQty < 0) return; // Prevent negative holdings
    
    final newHoldings = Map<String, int>.from(state.holdings);
    newHoldings[isin] = newQty;
    
    state = state.copyWith(holdings: newHoldings);
  }
}

final portfolioProvider = StateNotifierProvider<PortfolioNotifier, PortfolioState>((ref) {
  return PortfolioNotifier();
});
