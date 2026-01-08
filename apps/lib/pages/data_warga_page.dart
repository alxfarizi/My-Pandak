//data_warga_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tambah_data_data_warga_page.dart';
import '../controllers/anggota_keluarga_controller.dart';
import '../controllers/auth_controller.dart';

class DataWargaPage extends StatefulWidget {
  const DataWargaPage({super.key});

  @override
  State<DataWargaPage> createState() => _DataWargaPageState();
}

class _DataWargaPageState extends State<DataWargaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnggotaKeluargaController>().loadAllAnggota();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3D5A99),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.people, color: Colors.white, size: 25),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Warga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // FIXED: Conditional "Tambah Data" button - only for Admin/Pengurus
                      Consumer<AuthController>(
                        builder: (context, authController, child) {
                          if (authController.isPengurus) {
                            // Admin/Pengurus can add data manually
                            return ElevatedButton.icon(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TambahDataWargaPage(),
                                  ),
                                );
                                if (result == true) {
                                  context.read<AnggotaKeluargaController>().refresh();
                                }
                              },
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Tambah Data'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          } else {
                            // Warga - show info text instead of button
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Colors.blue.shade700, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Data warga otomatis ditambahkan dari Data Keluarga. Untuk menambah warga baru, edit Data Keluarga dan tambahkan anggota.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<AnggotaKeluargaController>(
                    builder: (context, anggotaController, child) {
                      if (anggotaController.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (anggotaController.error != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Error: ${anggotaController.error}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => anggotaController.refresh(),
                                child: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (anggotaController.anggotaList.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.only(top: 206),
                          alignment: Alignment.center,
                          child: Consumer<AuthController>(
                            builder: (context, authController, child) {
                              if (authController.isWarga) {
                                return const Text(
                                  'Belum ada data warga.\nSilahkan buat Data Keluarga terlebih dahulu untuk menambahkan anggota keluarga.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFA0A0A0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              } else {
                                return const Text(
                                  'Anda belum menambahkan data.\nSilahkan klik "⊕ tambah data" untuk menambahkan data warga !',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFA0A0A0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () => anggotaController.refresh(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              children: anggotaController.anggotaList.map((warga) {
                                return InkWell(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TambahDataWargaPage(
                                              initial: warga,
                                            ),
                                      ),
                                    );
                                    if (result == true) {
                                      anggotaController.refresh();
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8E8E8),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                warga.nama,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                warga.statusDalamKeluarga ??
                                                    'Anggota Keluarga',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          warga.nik ?? 'Belum ada NIK',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    },
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
