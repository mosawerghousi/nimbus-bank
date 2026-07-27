import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/cards/presentation/pages/card_detail_page.dart';
import '../../features/cards/presentation/pages/cards_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/profile/presentation/pages/help_page.dart';
import '../../features/profile/presentation/pages/linked_accounts_page.dart';
import '../../features/profile/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/pages/personal_info_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/security_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/transfer/presentation/pages/transfer_page.dart';
import '../../features/transfer/presentation/pages/transfer_review_page.dart';
import '../../features/transfer/presentation/pages/transfer_success_page.dart';
import 'main_shell.dart';

final _rootNavKey = GlobalKey<NavigatorState>();
final _shellNavKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _fadeThroughPage(
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => _fadeThroughPage(
        key: state.pageKey,
        child: const RegisterPage(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cards',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CardsPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/transactions',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: TransactionsPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfilePage()),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/card/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return _fadeThroughPage(
          key: state.pageKey,
          child: CardDetailPage(cardId: id),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/transfer',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const TransferPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/transfer/review',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const TransferReviewPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/transfer/success',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const TransferSuccessPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/profile/personal-info',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const PersonalInfoPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/profile/security',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const SecurityPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/profile/notifications',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const NotificationsPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/profile/linked-accounts',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const LinkedAccountsPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavKey,
      path: '/profile/help',
      pageBuilder: (context, state) => _slideUpPage(
        key: state.pageKey,
        child: const HelpPage(),
      ),
    ),
  ],
);

CustomTransitionPage<T> _fadeThroughPage<T>({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 320),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

CustomTransitionPage<T> _slideUpPage<T>({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 360),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}
