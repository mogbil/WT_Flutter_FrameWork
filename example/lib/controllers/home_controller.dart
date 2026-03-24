// ************************************************************
// * WT Flutter FrameWork
// * @version : 1.0
// * @copyright : 2024 WondTech for Integrated Digital Solutions
// * @link : http://www.wondtech.com
// ************************************************************

import 'package:flutter/material.dart';
import '../../lib/libs/mvc/wt_controller.dart';
import '../../lib/libs/mvc/wt_view.dart';
import '../../lib/libs/helpers/wt_session.dart';

class HomeController extends WtController {
  HomeController(super.settings);

  @override
  WtView view(BuildContext context) {
    final isLoggedIn = WtSession.isLoggedIn();
    final user = WtSession.getUser();

    final v = HomeView();
    v.assign('title', 'WT Framework — Home');
    v.assign('isLoggedIn', isLoggedIn);
    v.assign('userName', user?['name'] ?? '');
    v.assign('onLogout', () async {
      await WtSession.logout();
      if (context.mounted) redirect(context, '/login');
    });
    v.assign('onUsers', () => navigate(context, '/users'));
    v.assign('onLogin', () => navigate(context, '/login'));
    return v;
  }
}

// ── Home View (Template) ─────────────────────────────────

class HomeView extends WtView {
  @override
  Widget build(BuildContext context) {
    final isLoggedIn = get<bool>('isLoggedIn') ?? false;
    final userName = get<String>('userName') ?? '';
    final onLogout = get<Function>('onLogout');
    final onUsers = get<Function>('onUsers');
    final onLogin = get<Function>('onLogin');

    return scaffold(
      context: context,
      showAppBar: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1B2A), Color(0xFF1B4F72)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo / Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Text(
                        'WT Framework',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text('v1.0',
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 60),

                // Welcome
                Text(
                  isLoggedIn ? 'مرحباً،\n$userName 👋' : 'مرحباً بك في\nWT Framework',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'WondTech MVC Framework — Flutter Edition',
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                ),
                const SizedBox(height: 48),

                // Cards
                _FeatureCard(
                  icon: Icons.people_outline,
                  title: 'Users Module',
                  subtitle: 'MVC Controller + Model + View',
                  onTap: () => onUsers?.call(),
                ),
                const SizedBox(height: 16),
                _FeatureCard(
                  icon: Icons.lock_outline,
                  title: isLoggedIn ? 'Logout' : 'Login Module',
                  subtitle: isLoggedIn
                      ? 'WtSession::logout()'
                      : 'WtSession + WtSecurity',
                  onTap: isLoggedIn
                      ? () => onLogout?.call()
                      : () => onLogin?.call(),
                  color: isLoggedIn ? const Color(0xFFE74C3C) : const Color(0xFF27AE60),
                ),
                const Spacer(),

                // Framework info
                Center(
                  child: Text(
                    '© 2024 WondTech for Integrated Digital Solutions',
                    style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color = const Color(0xFF2980B9),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                          TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }
}
