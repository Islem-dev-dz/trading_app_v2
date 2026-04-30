import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthSelectionScreen extends StatefulWidget {
  const AuthSelectionScreen({super.key});

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Liste de vos contenus (Images + Textes)
  final List<Map<String, String>> _slides = [
    {
      "image": "assets/slide1.png", // Remplacez par vos chemins d'images
      "title": "Les meilleurs spreads sur l’or",
      "desc": "Négociez des actifs clés avec les spreads les plus serrés."
    },
    {
      "image": "assets/slide2.png",
      "title": "Le pétrole et le Bitcoin",
      "desc": "Accédez aux marchés mondiaux en un clic."
    },
    {
      "image": "assets/slide3.png",
      "title": "Sécurité BADR Invest",
      "desc": "Vos fonds sont protégés par une technologie de pointe."
    },
  ];

  @override
  void initState() {
    super.initState();
    // Timer de 2 secondes pour le scroll automatique
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgGreenSoft = Color(0xFFF4F7F5);
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color darkGreen = Color(0xFF1B5E20);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- 1. CARROUSEL D'IMAGES (SCROLLABLE) ---
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          _slides[index]["image"]!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          _slides[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          _slides[index]["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // --- 2. INDICATEURS (PETITS POINTS) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? primaryGreen
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- 3. BOUTONS D'ACTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Google
                  _buildSocialButton(
                    text: "Google",
                    icon: Icons.g_mobiledata,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  // S'inscrire
                  _buildMainButton(
                    text: "S'inscrire",
                    color: primaryGreen,
                    onPressed: () => context.push('/signup'),
                  ),
                  const SizedBox(height: 20),
                  // Séparateur "ou"
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("ou", style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Se connecter
                  _buildMainButton(
                    text: "Se connecter",
                    color: bgGreenSoft,
                    textColor: darkGreen,
                    onPressed: () => context.push('/login'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPERS BOUTONS ---
  Widget _buildMainButton(
      {required String text,
      required Color color,
      Color textColor = Colors.white,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildSocialButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black87, size: 30),
        label: Text(text,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF1F5F3),
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
