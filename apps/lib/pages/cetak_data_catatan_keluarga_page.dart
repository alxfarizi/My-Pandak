//cetak_data_catatan_keluarga_page.dart - DATA SYNC FIX
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'preview_catatan_keluarga_page.dart';
import '../controllers/catatan_keluarga_controller.dart';

class CetakCatatanKeluargaPage extends StatefulWidget {
  const CetakCatatanKeluargaPage({super.key});

  @override
  State<CetakCatatanKeluargaPage> createState() =>
      _CetakCatatanKeluargaPageState();
}

class _CetakCatatanKeluargaPageState extends State<CetakCatatanKeluargaPage> {
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
        title: const Text(
          'Cetak Catatan Keluarga',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih data catatan keluarga yang ingin dijadikan PDF',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 15),
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
                                onPressed: () =>
                                    catatanController.refreshAsMap(),
                                child: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (catatanController.catatanMapList.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Belum ada data catatan keluarga yang tersedia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFA0A0A0),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () => catatanController.refreshAsMap(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: catatanController.catatanMapList.map((
                                catatan,
                              ) {
                                // Extract data dengan safe access
                                final keluargaData =
                                    catatan['keluarga']
                                        as Map<String, dynamic>?;
                                final desaWismaData =
                                    keluargaData?['desa_wisma']
                                        as Map<String, dynamic>?;

                                final namaKepala =
                                    keluargaData?['nama_kepala_keluarga']
                                        ?.toString() ??
                                    'Tidak diketahui';
                                final namaDesa =
                                    desaWismaData?['nama_desa']?.toString() ??
                                    'Tidak diketahui';
                                final tahun =
                                    catatan['tahun']?.toString() ??
                                    'Tidak diketahui';

                                // FIXED: Convert to Map<String, String> dengan data real dari database
                                final Map<String, String> catatanMap = {
                                  // Basic identification
                                  'nama': namaKepala,
                                  'mawar': namaDesa,
                                  'tahun': tahun,
                                  'catatanDari':
                                      catatan['nama_pencatat']?.toString() ??
                                      namaKepala,
                                  'anggotaKelompok':
                                      catatan['anggota_kelompok_dasa_wisma']
                                          ?.toString() ??
                                      namaDesa,

                                  // Housing conditions
                                  'kriteriaRumah':
                                      catatan['kriteria_rumah']?.toString() ??
                                      '',
                                  'jambanKeluarga':
                                      (catatan['jamban_keluarga'] == true)
                                      ? 'Ya'
                                      : 'Tidak',
                                  'jumlahJambanOrang':
                                      catatan['jumlah_jamban_orang']
                                          ?.toString() ??
                                      '0',
                                  'tempatSampah':
                                      (catatan['tempat_sampah'] == true)
                                      ? 'Ada'
                                      : 'Tidak',
                                  'statusKesehatan':
                                      catatan['status_kesehatan']?.toString() ??
                                      '',

                                  // Additional info from keluarga relation
                                  'rt': keluargaData?['rt']?.toString() ?? '',
                                  'rw': keluargaData?['rw']?.toString() ?? '',
                                  'dusun':
                                      keluargaData?['dusun']?.toString() ?? '',
                                  'lingkungan':
                                      keluargaData?['lingkungan']?.toString() ??
                                      '',

                                  // Meta info
                                  'anggotaKelompokAda':
                                      'Ada', // Default value for UI compatibility
                                  'id': catatan['id']?.toString() ?? '',
                                  'keluargaId':
                                      catatan['keluarga_id']?.toString() ?? '',
                                  'tanggalPencatatan':
                                      catatan['tanggal_pencatatan']
                                          ?.toString() ??
                                      '',
                                  'status':
                                      catatan['status']?.toString() ?? 'Draft',
                                };

                                return GestureDetector(
                                  onTap: () async {
                                    // FIXED: Load full catatan data with anggota details
                                    final catatanId = catatan['id'];
                                    if (catatanId != null) {
                                      // Show loading
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );

                                      try {
                                        // Load full data with anggota details
                                        await catatanController
                                            .getCatatanByIdWithFullData(
                                              catatanId,
                                            );

                                        // Close loading dialog
                                        Navigator.pop(context);

                                        // Navigate to preview with enhanced data
                                        final enhancedCatatanMap = {
                                          ...catatanMap,
                                          // Add anggota data for table
                                          'anggotaData': catatanController
                                              .selectedCatatanAnggotaData,
                                        };

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewCatatanKeluargaPage(
                                                  catatanData: catatanMap,
                                                  anggotaData: catatanController
                                                      .selectedCatatanAnggotaData,
                                                ),
                                          ),
                                        );
                                      } catch (e) {
                                        // Close loading dialog
                                        Navigator.pop(context);

                                        // Show error
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Gagal memuat detail catatan: $e',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      // Fallback to basic preview
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PreviewCatatanKeluargaPage(
                                                catatanData: catatanMap,
                                              ),
                                        ),
                                      );
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
