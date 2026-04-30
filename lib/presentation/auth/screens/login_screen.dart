import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/presentation/auth/widgets/kyc_modal_overlay.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    // --- Palette de couleurs moderne ---
    const backgroundColor = Color(0xFFF5F7FA); // LightGray Premium

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // --- Décoration : Blobs de couleur en arrière-plan ---
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withValues(alpha: 0.08),
              ),
            ),
          ),

          // --- Contenu Principal ---
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- LOGO ---
                    Icon(
                      Icons.account_balance,
                      size: 70,
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'BADR Invest',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: const Color(0xFF2D3436),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Votre plateforme de courtage sécurisée',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 40),

                    // --- CONTAINER GLASSMORPHISM MODERNISÉ ---
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(alpha: 0.25), // Plus translucide
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.white
                                  .withValues(alpha: 0.5), // Bordure cristal
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Onglets Haut
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildTab("Se connecter", primaryColor,
                                      isActive: true),
                                  GestureDetector(
                                    onTap: () => context.push('/signup'),
                                    child: _buildTab(
                                        "Créer un compte", primaryColor,
                                        isActive: false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),

                              // Formulaire
                              _buildModernField(
                                label: 'Email',
                                icon: Icons.email_outlined,
                                isPassword: false,
                              ),
                              const SizedBox(height: 18),
                              _buildModernField(
                                label: 'Mot de passe',
                                icon: Icons.lock_outline,
                                isPassword: true,
                              ),

                              // Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 13),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Bouton Se Connecter
                              ElevatedButton(
                                onPressed: () => showKycModal(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  elevation: 0, // Flat design moderne
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Se connecter',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Label footer
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  ),
                                  GestureDetector(
                                    onTap: () => context.push('/signup'),
                                    child: Text(
                                      "Créer un compte",
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
        ],
      ),
    );
  }

  // Widget Helper pour des champs de saisie modernes
  Widget _buildModernField(
      {required String label,
      required IconData icon,
      required bool isPassword}) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: Colors.black45),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.4),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 1.5),
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
            margin: const EdgeInsets.only(top: 6),
            height: 3,
            width: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}
