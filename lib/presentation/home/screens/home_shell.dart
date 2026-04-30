import 'package:flutter/material.dart';
// Import de ton écran HomeScreen (Portefeuille)
import 'package:trading_app/presentation/home/screens/home_screen.dart';
// Import de l'écran des Ordres
import 'package:trading_app/presentation/orders/screens/orders_screen.dart';

// Note : L'importation de ProfileScreen a été supprimée car le fichier n'existe pas encore

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  // Liste des écrans corrigée
  final List<Widget> _screens = [
    const HomeScreen(), // Index 0 : Portefeuille
    const OrdersScreen(), // Index 1 : Ordres
    // On remplace ProfileScreen par un widget temporaire pour éviter l'erreur
    const Center(
        child: Text("Page Profil bientôt disponible")), // Index 2 : Profil
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Portefeuille',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Ordres',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
