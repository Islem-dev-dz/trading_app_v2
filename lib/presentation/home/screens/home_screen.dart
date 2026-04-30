import 'package:flutter/material.dart';
// Assure-toi que le chemin d'importation vers ton fichier de détail est correct
import 'package:trading_app/presentation/market/screens/market_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isKycValidated = false;
  bool isBankAccountAdded = false;
  int selectedIndex = 0;

  // --- LOGIQUE DE VÉRIFICATION AU CLIC ---
  // On attend bien le titre ET le symbole
  void _handleTileTap(String title, String symbol) {
    if (isKycValidated && isBankAccountAdded) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SecurityDetailScreen(title: title, symbol: symbol),
          fullscreenDialog: true,
        ),
      );
    } else {
      _showOnboardingModal();
    }
  }

  void _showOnboardingModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildMissingStepsOverlay(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Marché',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Sélecteur Segmenté
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 45,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                _buildSegmentItem("Secondaire", 0),
                _buildSegmentItem("Primaire", 1),
              ],
            ),
          ),

          // Liste des titres
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: selectedIndex == 0 ? 10 : 3,
              itemBuilder: (context, index) {
                // Définition du titre et du symbole selon l'onglet
                String title =
                    selectedIndex == 0 ? "Sonatrach SNT" : "Trésor Public";
                String symbol = selectedIndex == 0 ? "SNT" : "DZ-BOND";

                return InkWell(
                  // CORRECTION : On passe maintenant les deux arguments requis
                  onTap: () => _handleTileTap(title, symbol),
                  child: _buildModernTile(index, title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- MODAL DES ÉTAPES MANQUANTES ---
  Widget _buildMissingStepsOverlay() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Finalisez votre profil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
              "Pour commencer à investir sur le marché, les étapes suivantes sont nécessaires :",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          if (!isKycValidated)
            _buildStepAction(
              title: "Vérification d'identité (KYC)",
              subtitle: "Requis pour la sécurité de vos fonds",
              icon: Icons.person_search_outlined,
              onTap: () {
                Navigator.pop(context);
                // Action pour passer à true pour tester :
                setState(() => isKycValidated = true);
              },
            ),
          if (!isKycValidated && !isBankAccountAdded)
            const SizedBox(height: 12),
          if (!isBankAccountAdded)
            _buildStepAction(
              title: "Ajouter un compte bancaire",
              subtitle: "Lier votre compte pour les virements",
              icon: Icons.account_balance_outlined,
              onTap: () {
                Navigator.pop(context);
                // Action pour passer à true pour tester :
                setState(() => isBankAccountAdded = true);
              },
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStepAction(
      {required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.shade100),
          color: Colors.blue.withValues(alpha: 0.05),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue.shade800, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle,
                      style: TextStyle(
                          color: Colors.blue.shade900.withValues(alpha: 0.6),
                          fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentItem(String label, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2))
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(label,
              style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue.shade800 : Colors.grey)),
        ),
      ),
    );
  }

  // J'ai ajouté l'argument title ici pour que l'affichage soit cohérent
  Widget _buildModernTile(int index, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(selectedIndex == 0 ? "⚡" : "🏢",
                    style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                    selectedIndex == 0 ? "+2.4% aujourd'hui" : "Offre en cours",
                    style: TextStyle(
                        color:
                            selectedIndex == 0 ? Colors.green : Colors.orange,
                        fontSize: 12)),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("4,500 DZD", style: TextStyle(fontWeight: FontWeight.w900)),
              Text("Vol: 1.2M",
                  style: TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
