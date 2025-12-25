import 'package:flutter/material.dart';
import 'preview_catatan_keluarga_page.dart';
import '../controllers/catatan_controller.dart';
import '../data/models/catatan.dart';

class CetakCatatanKeluargaPage extends StatefulWidget {
  const CetakCatatanKeluargaPage({super.key});

  @override
  State<CetakCatatanKeluargaPage> createState() =>
      _CetakCatatanKeluargaPageState();
}

class _CetakCatatanKeluargaPageState extends State<CetakCatatanKeluargaPage> {
  final CatatanController _controller = CatatanController();
  List<Catatan> _catatanData = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final rows = await _controller.loadCatatan();
    setState(() => _catatanData = rows);
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
                  child: _catatanData.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Belum ada data yang tersedia sehingga belum bisa review catatan keluarga',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFA0A0A0),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: _catatanData
                                  .map(
                                    (catatan) => GestureDetector(
                                      onTap: () {
                                        final mapData = {
                                          'nama': catatan.nama,
                                          'mawar': catatan.mawar,
                                          'tahun': catatan.tahun,
                                          'kriteriaRumah':
                                              catatan.kriteriaRumah ?? '',
                                          'jambanKeluarga':
                                              catatan.jambanKeluarga ?? '',
                                          'jumlahJambanOrang':
                                              catatan.jumlahJambanOrang ?? '',
                                          'kesehatan': catatan.kesehatan ?? '',
                                          'anggotaKeluarga':
                                              catatan.anggotaKeluarga ?? '',
                                        };
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewCatatanKeluargaPage(
                                                  catatanData: mapData,
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
                                                    catatan.nama,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    catatan.mawar,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              catatan.tahun,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
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
