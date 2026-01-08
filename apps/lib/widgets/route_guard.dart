//route_guard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../pages/login_page.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;
  final List<String>? allowedRoles;
  final bool requireAuth;

  const RouteGuard({
    super.key,
    required this.child,
    this.allowedRoles,
    this.requireAuth = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, _) {
        // Check if authentication is required
        if (requireAuth && !authController.isLoggedIn) {
          return const LoginPage();
        }

        // Check role permissions
        if (allowedRoles != null && allowedRoles!.isNotEmpty) {
          if (!authController.isLoggedIn) {
            return const LoginPage();
          }

          final userRole = authController.userRole;
          if (!allowedRoles!.contains(userRole)) {
            return _buildAccessDeniedPage(context, userRole); // FIXED: Pass context
          }
        }

        return child;
      },
    );
  }

  // FIXED: Add context parameter
  Widget _buildAccessDeniedPage(BuildContext context, String userRole) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Akses Ditolak',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.block,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 24),
              const Text(
                'Akses Ditolak',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Maaf, role "$userRole" tidak memiliki akses ke halaman ini.\n\nHanya Admin dan Pengurus yang dapat mengakses fitur ini.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3669),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
