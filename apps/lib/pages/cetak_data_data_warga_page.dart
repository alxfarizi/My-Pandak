//cetak_data_data_warga_page.dart - TYPE FIX
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'preview_data_warga_page.dart';
import '../controllers/anggota_keluarga_controller.dart';

class CetakDataWargaPage extends StatefulWidget {
  const CetakDataWargaPage({super.key});

  @override
  State<CetakDataWargaPage> createState() => _CetakDataWargaPageState();
}

class _CetakDataWargaPageState extends State<CetakDataWargaPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnggotaKeluargaController>().loadAllAnggotaWithKeluarga();
    });
  }

  // Helper method untuk format tanggal lahir
  String _formatTanggalLahir(DateTime? tanggalLahir, int? umur) {
    if (tanggalLahir != null) {
      return '${tanggalLahir.day.toString().padLeft(2, '0')}/${tanggalLahir.month.toString().padLeft(2, '0')}/${tanggalLahir.year}';
    }
    if (umur != null) {
      return '$umur tahun';
    }
    return '';
  }

  // Helper method untuk format jenis kelamin
  String _formatJenisKelamin(String? jenisKelamin) {
    if (jenisKelamin == 'L') return 'Laki-laki';
    if (jenisKelamin == 'P') return 'Perempuan';
    return jenisKelamin ?? '';
  }

  // FIXED: Helper method untuk convert dynamic value ke string
  String _safeToString(dynamic value) {
    return value?.toString() ?? '';
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
          'Cetak Data Warga',
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih data warga yang ingin dijadikan PDF',
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
                                onPressed: () =>
                                    anggotaController.refreshWithKeluarga(),
                                child: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (anggotaController.anggotaWithKeluargaList.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Belum ada data warga yang tersedia',
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
                        onRefresh: () =>
                            anggotaController.refreshWithKeluarga(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: anggotaController
                                  .anggotaWithKeluargaList
                                  .map((wargaWithKeluarga) {
                                    final warga = wargaWithKeluarga['anggota'];
                                    final keluarga =
                                        wargaWithKeluarga['keluarga']
                                            as Map<String, dynamic>?;
                                    final desaWisma =
                                        wargaWithKeluarga['desa_wisma']
                                            as Map<String, dynamic>?;

                                    return GestureDetector(
                                      onTap: () {
                                        // FIXED: Convert all values to String untuk Map<String, String>
                                        final wargaMap = <String, String>{
                                          // Basic info
                                          'nama': warga?.nama ?? '',
                                          'nik': warga?.nik ?? 'Belum ada NIK',
                                          'noRegistrasi':
                                              warga?.noRegistrasi ?? '',
                                          'jabatan': warga?.jabatan ?? '',

                                          // Personal info
                                          'jenisKelamin': _formatJenisKelamin(
                                            warga?.jenisKelamin,
                                          ),
                                          'tempatLahir':
                                              warga?.tempatLahir ?? '',
                                          'tanggalLahir': _formatTanggalLahir(
                                            warga?.tanggalLahir,
                                            warga?.umur,
                                          ),
                                          'umur': _safeToString(warga?.umur),
                                          'statusPerkawinan':
                                              warga?.statusPerkawinan ?? '',
                                          'statusDalamKeluarga':
                                              warga?.statusDalamKeluarga ?? '',
                                          'agama': warga?.agama ?? '',

                                          // Address info
                                          'alamat': warga?.alamatDetail ?? '',
                                          'statusTinggal':
                                              warga?.statusTinggal ?? '',
                                          'desaKelurahan':
                                              warga?.desaKelurahan ?? '',
                                          'kabupatenKota':
                                              warga?.kabupatenKota ?? '',

                                          // Education & work
                                          'pendidikan': warga?.pendidikan ?? '',
                                          'pekerjaan': warga?.pekerjaan ?? '',

                                          // Health & social programs
                                          'akseptorKb':
                                              warga?.akseptorKb == true
                                              ? 'Ya'
                                              : 'Tidak',
                                          'jenisAkseptorKb':
                                              warga?.jenisAkseptorKb ?? '',
                                          'aktifPosyandu':
                                              warga?.aktifPosyandu == true
                                              ? 'Ya'
                                              : 'Tidak',
                                          'frekuensiPosyandu': _safeToString(
                                            warga?.frekuensiPosyandu ?? 0,
                                          ),
                                          'mengikutiBinaBalita':
                                              warga?.mengikutiBinaBalita == true
                                              ? 'Ya'
                                              : 'Tidak',
                                          'memilikiTabungan':
                                              warga?.memilikiTabungan == true
                                              ? 'Ya'
                                              : 'Tidak',
                                          'jenisPaketTabungan':
                                              warga?.jenisPaketTabungan ?? '',
                                          'mengikutiPaud':
                                              warga?.mengikutiPaud == true
                                              ? 'Ya'
                                              : 'Tidak',
                                          'ikutKoperasi':
                                              warga?.ikutKoperasi == true
                                              ? 'Ya'
                                              : 'Tidak',
                                          'berkebutuhanKhusus':
                                              warga?.berkebutuhanKhusus == true
                                              ? 'Ya'
                                              : 'Tidak',

                                          // Family & location info
                                          'namaKepalaKeluarga': _safeToString(
                                            keluarga?['nama_kepala_keluarga'],
                                          ),
                                          'rt': _safeToString(keluarga?['rt']),
                                          'rw': _safeToString(keluarga?['rw']),
                                          'dusun': _safeToString(
                                            keluarga?['dusun'],
                                          ),
                                          'lingkungan': _safeToString(
                                            keluarga?['lingkungan'],
                                          ),
                                          'mawar':
                                              _safeToString(
                                                    desaWisma?['nama_desa'],
                                                  ) !=
                                                  ''
                                              ? _safeToString(
                                                  desaWisma?['nama_desa'],
                                                )
                                              : 'Desa Wisma',
                                        };

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewDataWargaPage(
                                                  wargaData: wargaMap,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8E8E8),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                                                    warga?.nama ??
                                                        'Nama tidak diketahui',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    warga?.statusDalamKeluarga ??
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
                                              warga?.nik ?? 'Belum ada NIK',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
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
