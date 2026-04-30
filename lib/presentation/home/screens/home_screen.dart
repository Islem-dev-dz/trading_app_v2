import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // États de l'utilisateur (Simulation)
  bool isKycValidated = false;
  bool isBankAccountAdded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Comptes',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black87),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: isKycValidated
                  ? () => _showAddAccountSheet(context)
                  : () => _showRestrictionSnackBar(
                      context, "Complétez votre KYC pour ajouter un compte."),
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isKycValidated ? primaryColor : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. BANNIÈRE KYC
          if (!isKycValidated)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildKycBanner(primaryColor),
              ),
            ),

          // 2. BOUTONS DE MARCHÉ
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  _buildMarketTab(
                      "Marché Primaire", Icons.business_rounded, Colors.blue),
                  const SizedBox(width: 12),
                  _buildMarketTab("Marché Secondaire", Icons.analytics_rounded,
                      Colors.green),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // 3. LISTE DES TITRES
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildSecurityTile(index),
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
      // Note: Le bottomNavigationBar est normalement géré par HomeShell,
      // mais je le laisse ici si tu veux tester cette page seule.
    );
  }

  Widget _buildKycBanner(Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Column(
        children: [
          const Text(
            "Complétez votre identité pour débloquer toutes les fonctionnalités.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              setState(() => isKycValidated = true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Vérifier maintenant"),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketTab(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTile(int index) {
    return InkWell(
      onTap: isBankAccountAdded
          ? () => debugPrint("Accès au titre $index")
          : () => _showRestrictionSnackBar(
              context, "Ajoutez un compte bancaire pour trader ce titre."),
      child: Opacity(
        // Correction ici : On utilise le widget Opacity pour griser le contenu
        opacity: isBankAccountAdded ? 1.0 : 0.6,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  child: const Text("💰")),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Action SONATRACH",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("SNT - Marché Primaire",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const Text("4,500 DZD",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  void _showRestrictionSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAddAccountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Ajouter un compte bancaire",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
              "Veuillez lier votre compte BADR Bank pour commencer vos transactions.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() => isBankAccountAdded = true);
                    Navigator.pop(context);
                  },
                  child: const Text("Confirmer l'ajout")),
            ),
          ],
        ),
      ),
    );
  }
}
