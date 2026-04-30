import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Ces variables simulent l'état de l'utilisateur
  bool isKycValidated = false;
  bool isBankAccountAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. SECTION ÉTAPES DE VÉRIFICATION
            if (!isKycValidated)
              _buildStatusCard(
                title: "Vérification KYC",
                subtitle: "Finalisez votre identité pour trader",
                icon: Icons.person_outline,
                color: Colors.orange,
                onTap: () => setState(() => isKycValidated = true),
              ),

            if (!isKycValidated && !isBankAccountAdded)
              const SizedBox(height: 12),

            if (!isBankAccountAdded)
              _buildStatusCard(
                title: "Compte Bancaire",
                subtitle: "Liez un compte pour vos retraits",
                icon: Icons.account_balance_outlined,
                color: Colors.blue,
                onTap: () => setState(() => isBankAccountAdded = true),
              ),

            const SizedBox(height: 30),

            // 2. SECTION ACTIONS DU COMPTE
            _buildProfileMenuTile(
              title: "Modifier mes infos",
              icon: Icons.edit_outlined,
              onTap: () {
                // Action pour modifier le profil
              },
            ),
            _buildProfileMenuTile(
              title: "Se déconnecter",
              icon: Icons.logout,
              textColor: Colors.black,
              onTap: () => _showLogoutDialog(context),
            ),

            const Divider(height: 40),

            // 3. ZONE DANGER
            _buildProfileMenuTile(
              title: "Supprimer le profil",
              icon: Icons.delete_forever_outlined,
              textColor: Colors.red,
              onTap: () => _showDeleteRequestDialog(context),
            ),
            const SizedBox(height: 10),
            const Text(
              "Note : La suppression n'est pas immédiate et fera l'objet d'une demande traitée sous 48h.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: textColor ?? Colors.black87),
      title: Text(title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Voulez-vous vraiment vous déconnecter ?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Logique de déconnexion
              },
              child: const Text("Se déconnecter",
                  style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  void _showDeleteRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Demande de suppression"),
        content: const Text(
            "Votre demande sera transmise à l'administration. Elle sera traitée après vérification de vos transactions en cours."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Demande de suppression envoyée.")),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Confirmer la demande"),
          ),
        ],
      ),
    );
  }
}
