import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/presentation/auth/widgets/kyc_modal_overlay.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                  // --- LOGO (IDENTIQUE AU LOGIN) ---
                  Icon(
                    Icons.account_balance,
                    size: 80,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'BADR Invest',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Rejoignez la révolution du trading',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),

                  // --- CONTAINER GLASSMORPHISM ---
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
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Onglets Haut (Inversé pour Signup)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => context.pop(), // Retour au Login
                                  child: _buildTab("Se connecter", primaryColor,
                                      isActive: false),
                                ),
                                _buildTab("Créer un compte", primaryColor,
                                    isActive: true),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Create a new account to start trading.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 13),
                            ),
                            const SizedBox(height: 24),

                            // Formulaire
                            _buildInputField(
                              label: 'Email',
                              icon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 16),
                            _buildInputField(
                              label: 'Mot de passe',
                              icon: Icons.lock_outline,
                              obscureText: true,
                            ),
                            const SizedBox(height: 16),
                            _buildInputField(
                              label: 'Confirmer le mot de passe',
                              icon: Icons.lock_clock_outlined,
                              obscureText: true,
                            ),
                            const SizedBox(height: 32),

                            // Bouton Créer mon compte
                            ElevatedButton(
                              onPressed: () => showKycModal(context),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text('Créer mon compte'),
                            ),
                            const SizedBox(height: 24),

                            // Label footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: Text(
                                    "Se connecter",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
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

  // Widget Helper pour les champs de saisie
  Widget _buildInputField({
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Widget pour les onglets
  Widget _buildTab(String label, Color color, {required bool isActive}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isActive ? color : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}
