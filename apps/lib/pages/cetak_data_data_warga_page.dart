import 'package:flutter/material.dart';
import 'preview_data_warga_page.dart';
import '../controllers/warga_controller.dart';
import '../data/models/warga.dart';

class CetakDataWargaPage extends StatefulWidget {
  const CetakDataWargaPage({super.key});

  @override
  State<CetakDataWargaPage> createState() => _CetakDataWargaPageState();
}

class _CetakDataWargaPageState extends State<CetakDataWargaPage> {
  final WargaController _controller = WargaController();
  List<Warga> _wargaData = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final rows = await _controller.loadWarga();
    setState(() => _wargaData = rows);
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
                  child: _wargaData.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Belum ada data yang tersedia sehingga belum bisa review data warga',
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
                              children: [
                                ..._wargaData.map(
                                  (w) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PreviewDataWargaPage(
                                                wargaData: {
                                                  'nama': w.nama,
                                                  'mawar': w.mawar,
                                                  'nik': w.nik,
                                                  'jabatan': w.jabatan ?? '',
                                                  'tempatLahir':
                                                      w.tempatLahir ?? '',
                                                  'alamat': w.alamat ?? '',
                                                  'jenisKelamin':
                                                      w.jenisKelamin ?? '',
                                                  'statusPerkawinan':
                                                      w.statusPerkawinan ?? '',
                                                  'statusDalamKeluarga':
                                                      w.statusDalamKeluarga ??
                                                      '',
                                                  'agama': w.agama ?? '',
                                                  'pendidikan':
                                                      w.pendidikan ?? '',
                                                  'pekerjaan':
                                                      w.pekerjaan ?? '',
                                                  'akseptorKb':
                                                      w.akseptorKb ?? '',
                                                  'aktifPosyandu':
                                                      w.aktifPosyandu ?? '',
                                                  'binaBalita':
                                                      w.binaBalita ?? '',
                                                  'memilikiTabungan':
                                                      w.memilikiTabungan ?? '',
                                                  'paketTabungan':
                                                      w.paketTabungan ?? '',
                                                  'ikutPaud': w.ikutPaud ?? '',
                                                  'ikutKoperasi':
                                                      w.ikutKoperasi ?? '',
                                                  'berkebutuhanKhusus':
                                                      w.berkebutuhanKhusus ??
                                                      '',
                                                  'tanggalLahir':
                                                      w.tanggalLahir ?? '',
                                                  'bulanLahir':
                                                      w.bulanLahir ?? '',
                                                  'tahunLahir':
                                                      w.tahunLahir ?? '',
                                                  'umur': w.umur ?? '',
                                                  'frekuensiPosyandu':
                                                      w.frekuensiPosyandu ?? '',
                                                },
                                              ),
                                        ),
                                      );
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
                                                  w.nama,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  w.mawar,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            w.nik,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
