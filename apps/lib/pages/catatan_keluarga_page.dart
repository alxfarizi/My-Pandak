//catatan_keluarga_page.dart - FIXED WARGA LIMITATION
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tambah_data_catatan_keluarga_page.dart';
import '../controllers/catatan_keluarga_controller.dart';
import '../controllers/auth_controller.dart';

class CatatanKeluargaPage extends StatefulWidget {
  const CatatanKeluargaPage({super.key});

  @override
  State<CatatanKeluargaPage> createState() => _CatatanKeluargaPageState();
}

class _CatatanKeluargaPageState extends State<CatatanKeluargaPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatatanKeluargaController>().loadAllCatatanAsMap();
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
              color: const Color(0xFFFFA726),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.note, color: Colors.white, size: 25),
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
                        'Catatan Keluarga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // FIXED: Conditional button based on user role and existing data
                      Consumer2<AuthController, CatatanKeluargaController>(
                        builder: (context, authController, catatanController, child) {
                          final isWarga = authController.isWarga;
                          final hasData = catatanController.catatanMapList.isNotEmpty;

                          // FIXED: Warga can only add once, Admin/Pengurus can add multiple
                          if (isWarga && hasData) {
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
                                      'Anda sudah memiliki catatan keluarga. Klik pada data untuk mengedit.',
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
                          } else {
                            return ElevatedButton.icon(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const TambahDataCatatanKeluargaPage(),
                                  ),
                                );
                                // Refresh data jika ada perubahan
                                if (result == true) {
                                  context.read<CatatanKeluargaController>().refreshAsMap();
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
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<CatatanKeluargaController>(
                    builder: (context, catatanController, child) {
                      if (catatanController.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (catatanController.error != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Error: ${catatanController.error}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => catatanController.refreshAsMap(),
                                child: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (catatanController.catatanMapList.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.only(top: 206),
                          alignment: Alignment.center,
                          child: const Text(
                            'Anda belum menambahkan data.\nSilahkan klik "⊕ tambah data" untuk menambahkan catatan keluarga !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () => catatanController.refreshAsMap(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              children: catatanController.catatanMapList.map((catatan) {
                                // Extract data dengan safe access
                                final keluargaData =
                                catatan['keluarga']
                                as Map<String, dynamic>?;
                                final desaWismaData =
                                keluargaData?['desa_wisma']
                                as Map<String, dynamic>?;

                                final namaKepala =
                                    keluargaData?['nama_kepala_keluarga'] ??
                                        'Tidak diketahui';
                                final namaDesa =
                                    desaWismaData?['nama_desa'] ??
                                        'Tidak diketahui';
                                final tahun =
                                    catatan['tahun']?.toString() ??
                                        'Tidak diketahui';

                                return GestureDetector(
                                  onTap: () async {
                                    // Navigate ke edit page dengan data initial
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TambahDataCatatanKeluargaPage(
                                              initialData: catatan,
                                            ),
                                      ),
                                    );
                                    if (result == true) {
                                      catatanController.refreshAsMap();
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
                                                namaKepala,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                namaDesa,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          tahun,
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
