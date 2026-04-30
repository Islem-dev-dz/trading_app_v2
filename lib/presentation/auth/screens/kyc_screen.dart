import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              primaryColor.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security_rounded, size: 70, color: primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    'Vérification KYC',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- CONTAINER PRINCIPAL ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Documents requis",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 20),

                            // 1. CHOIX DU TYPE DE DOCUMENT
                            _buildStepTile(
                              icon: Icons.badge_outlined,
                              title: "Type de document",
                              subtitle: "CNI, Passeport ou Permis",
                              isDone: true, // Exemple d'état sélectionné
                              onTap: () {
                                // Ouvrir un sélecteur (ModalBottomSheet)
                              },
                            ),
                            const SizedBox(height: 12),

                            // 2. PHOTO DU DOCUMENT
                            _buildStepTile(
                              icon: Icons.camera_front_outlined,
                              title: "Photo du document",
                              subtitle: "Assurez-vous que le texte est lisible",
                              isDone: false,
                              onTap: () {
                                // Logique caméra pour le document
                              },
                            ),
                            const SizedBox(height: 12),

                            // 3. SELFIE
                            _buildStepTile(
                              icon: Icons.face_retouching_natural_outlined,
                              title: "Prendre un selfie",
                              subtitle: "Regardez droit vers l'objectif",
                              isDone: false,
                              onTap: () {
                                // Logique caméra frontale
                              },
                            ),

                            const SizedBox(height: 32),

                            // BOUTON VALIDER
                            ElevatedButton(
                              onPressed: () => context.push('/kyc-pending'),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              child: const Text('Envoyer mon dossier'),
                            ),

                            const SizedBox(height: 12),

                            TextButton(
                              onPressed: () => context.go('/home'),
                              child: const Text(
                                'Peut-être plus tard',
                                style: TextStyle(
                                    color: Colors.black54,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour chaque étape (Document / Selfie)
  Widget _buildStepTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDone,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDone
              ? Colors.green.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color:
                isDone ? Colors.green.withValues(alpha: 0.3) : Colors.black12,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isDone ? Colors.green : Colors.grey.shade200,
              child: Icon(isDone ? Icons.check : icon,
                  color: isDone ? Colors.white : Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}
