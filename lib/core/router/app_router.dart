import 'package:go_router/go_router.dart';
// 1. Ajoute l'import de ta nouvelle page (vérifie bien le chemin du fichier)
import 'package:trading_app/presentation/auth/screens/auth_selection_screen.dart';
import 'package:trading_app/presentation/auth/screens/login_screen.dart';
import 'package:trading_app/presentation/auth/screens/signup_screen.dart';
import 'package:trading_app/presentation/auth/screens/kyc_screen.dart';
import 'package:trading_app/presentation/auth/screens/bank_link_screen.dart';
import 'package:trading_app/presentation/auth/screens/kyc_pending_screen.dart';
import 'package:trading_app/presentation/home/screens/home_shell.dart';
import 'package:trading_app/presentation/auth/screens/manage_accounts_screen.dart';
import 'package:trading_app/presentation/market/screens/market_detail_screen.dart';
import 'package:trading_app/presentation/profile/profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // 2. MODIFICATION ICI : Remplace LoginScreen par AuthSelectionScreen
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthSelectionScreen(),
    ),

    // On garde la route /login pour pouvoir y accéder depuis la page de sélection
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/kyc',
      builder: (context, state) => const KycScreen(),
    ),
    GoRoute(
      path: '/bank-link',
      builder: (context, state) => const BankLinkScreen(),
    ),
    GoRoute(
      path: '/kyc-pending',
      builder: (context, state) => const KycPendingScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/market',
      builder: (context, state) => const HomeShell(),
    ),
    GoRoute(
      path: '/manage-accounts',
      builder: (context, state) => const ManageAccountsScreen(),
    ),
    GoRoute(
      path: '/market-detail',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SecurityDetailScreen(
          title: extra?['title'] as String? ?? 'Détail',
          symbol: extra?['symbol'] as String? ?? 'N/A',
        );
      },
    ),
  ],
);
