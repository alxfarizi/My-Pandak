//dashboard_page.dart - FINAL ENHANCED VERSION WITH GOOGLE MAPS
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // ADDED: Import Google Maps
import 'data_warga_page.dart';
import 'data_keluarga_page.dart';
import 'catatan_keluarga_page.dart';
import 'pengaturan_page.dart';
import 'cetak_data_page.dart';
import 'register_warga_page.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/auth_controller.dart';
import '../services/user_integration_service.dart';
import '../widgets/route_guard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic> _userSummary = {};
  bool _isLoadingUserSummary = true;

  // ADDED: Google Maps configuration
  static final LatLng _desaPandakLocation = const LatLng(-7.37778, 109.24083);
  static final CameraPosition _cameraPosition = CameraPosition(
    target: _desaPandakLocation,
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDashboardData();
    });
  }

  Future<void> _loadDashboardData() async {
    final dashboardController = context.read<DashboardController>();

    // Load dashboard stats
    await dashboardController.loadDashboardStats();

    // FIXED: Load user integration summary
    await _loadUserSummary();
  }

  Future<void> _loadUserSummary() async {
    setState(() {
      _isLoadingUserSummary = true;
    });

    try {
      final summary = await UserIntegrationService.getUserDashboardSummary();
      setState(() {
        _userSummary = summary;
      });
    } catch (e) {
      print('Error loading user summary: $e');
    } finally {
      setState(() {
        _isLoadingUserSummary = false;
      });
    }
  }

  // FIXED: Handle user sync action
  Future<void> _handleUserSync() async {
    try {
      final success = await UserIntegrationService.autoFixUserIntegration();
      if (success) {
        _showSuccess('Data berhasil disinkronkan!');
        await _loadUserSummary(); // Refresh summary
      } else {
        _showError('Gagal sinkronisasi data');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void navigateToSettings(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const SettingsPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
      ),
    );
  }

  void navigateToCetakData(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const CetakDataPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
      ),
    );
  }

  void navigateToRegister(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => RouteGuard(
          allowedRoles: const ['Admin', 'Pengurus'],
          child: const RegisterWargaPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Consumer<AuthController>(
          builder: (context, authController, child) {
            final userName = authController.userProfile?['nama_lengkap'] ?? 'User';
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'Hai, $userName !',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications, size: 24),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FIXED: User status notification
                if (!_isLoadingUserSummary && _userSummary['needsAttention'] == true)
                  _buildUserAttentionCard(),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<AuthController>(
                        builder: (context, authController, child) {
                          final userRole = authController.userRole;
                          return Text(
                            'Selamat datang, $userRole',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C4A7C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Consumer<DashboardController>(
                          builder: (context, dashboardController, child) {
                            if (dashboardController.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              );
                            }

                            if (dashboardController.error != null) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Error: ${dashboardController.error}',
                                      style: const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () => dashboardController.refresh(),
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _StatItem(
                                  icon: Icons.groups,
                                  count: '${dashboardController.totalAnggota}',
                                  label: 'Total\nWarga',
                                ),
                                _StatItem(
                                  icon: Icons.group,
                                  count: '${dashboardController.totalKeluarga}',
                                  label: 'Kepala\nKeluarga',
                                ),
                                _StatItem(
                                  icon: Icons.family_restroom,
                                  count: '${dashboardController.totalMenikah}',
                                  label: 'Total\nMenikah',
                                ),
                                _StatItem(
                                  icon: Icons.child_care,
                                  count: '${dashboardController.totalBelumMenikah}',
                                  label: 'Belum\nMenikah',
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data buku desa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _MenuCard(
                            icon: Icons.people,
                            label: 'Data\nWarga',
                            color: const Color(0xFF3D5A99),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DataWargaPage(),
                              ),
                            ),
                          ),
                          _MenuCard(
                            icon: Icons.home_filled,
                            label: 'Data\nKeluarga',
                            color: const Color(0xFF4CAF50),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DataKeluargaPage(),
                              ),
                            ),
                          ),
                          _MenuCard(
                            icon: Icons.note,
                            label: 'Catatan\nKeluarga',
                            color: const Color(0xFFFFA726),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CatatanKeluargaPage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lokasi desa pandak',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // REPLACED: Google Maps implementation
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GoogleMap(
                            initialCameraPosition: _cameraPosition,
                            myLocationEnabled: false,
                            zoomControlsEnabled: true,
                            mapType: MapType.normal,
                            markers: {
                              Marker(
                                markerId: const MarkerId('desa_pandak'),
                                position: _desaPandakLocation,
                                infoWindow: const InfoWindow(
                                  title: 'Desa Pandak',
                                ),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<AuthController>(
        builder: (context, authController, child) {
          if (authController.isWarga) {
            return _buildWargaBottomNav(context);
          } else {
            return _buildPengurusBottomNav(context, authController.isPengurus);
          }
        },
      ),
    );
  }

  // FIXED: User attention card for sync issues
  Widget _buildUserAttentionCard() {
    final actionItems = _userSummary['actionItems'] as List<dynamic>? ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange[600]),
              const SizedBox(width: 8),
              const Text(
                'Perhatian',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Ada beberapa hal yang perlu diselesaikan:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          ...actionItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(item.toString(), style: const TextStyle(fontSize: 13))),
              ],
            ),
          )),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _handleUserSync,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.sync, size: 18),
              label: const Text(
                'Perbaiki Sekarang',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWargaBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2C4A7C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.print),
              label: 'Cetak Data'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        onTap: (index) {
          if (index == 0) return; // Already on dashboard
          if (index == 1) {
            navigateToCetakData(context);
          } else if (index == 2) {
            navigateToSettings(context);
          }
        },
      ),
    );
  }

  Widget _buildPengurusBottomNav(BuildContext context, bool isPengurus) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2C4A7C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.print),
              label: 'Cetak Data'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registrasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        onTap: (index) {
          if (index == 0) return; // Already on dashboard
          if (index == 1) {
            navigateToCetakData(context);
          } else if (index == 2) {
            navigateToRegister(context);
          } else if (index == 3) {
            navigateToSettings(context);
          }
        },
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;

  const _StatItem({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF2C4A7C), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
