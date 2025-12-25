import 'package:flutter/material.dart';
import 'preview_data_keluarga_page.dart';
import '../controllers/keluarga_controller.dart';
import '../data/models/keluarga.dart';

class CetakDataKeluargaPage extends StatefulWidget {
  const CetakDataKeluargaPage({super.key});

  @override
  State<CetakDataKeluargaPage> createState() => _CetakDataKeluargaPageState();
}

class _CetakDataKeluargaPageState extends State<CetakDataKeluargaPage> {
  final KeluargaController _controller = KeluargaController();
  List<Keluarga> _keluargaData = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final rows = await _controller.loadKeluarga();
    setState(() => _keluargaData = rows);
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
          'Cetak Data Keluarga',
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
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.home_filled, color: Colors.white, size: 25),
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
                        'Pilih data keluarga yang ingin dijadikan PDF',
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
                  child: _keluargaData.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Belum ada data yang tersedia sehingga belum bisa review data keluarga',
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
                                ..._keluargaData.map(
                                  (keluarga) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PreviewDataKeluargaPage(
                                                keluargaData: {
                                                  'nama': keluarga.nama,
                                                  'mawar': keluarga.mawar,
                                                  'jumlah': keluarga.jumlah,
                                                  'rt': keluarga.rt ?? '',
                                                  'rw': keluarga.rw ?? '',
                                                  'dusun': keluarga.dusun ?? '',
                                                  'lingkungan':
                                                      keluarga.lingkungan ?? '',
                                                  'jumlahLaki':
                                                      keluarga.jumlahLaki ?? '',
                                                  'jumlahPerempuan':
                                                      keluarga
                                                          .jumlahPerempuan ??
                                                      '',
                                                  'jumlahKk':
                                                      keluarga.jumlahKk ?? '',
                                                  'balita':
                                                      keluarga.balita ?? '',
                                                  'pus': keluarga.pus ?? '',
                                                  'wus': keluarga.wus ?? '',
                                                  'buta': keluarga.buta ?? '',
                                                  'ibuHamil':
                                                      keluarga.ibuHamil ?? '',
                                                  'ibuMenyusui':
                                                      keluarga.ibuMenyusui ??
                                                      '',
                                                  'lansia':
                                                      keluarga.lansia ?? '',
                                                  'lansiaKriteria':
                                                      keluarga.lansiaKriteria ??
                                                      '',
                                                  'makananPokok':
                                                      keluarga.makananPokok ??
                                                      '',
                                                  'jambanKeluarga':
                                                      keluarga.jambanKeluarga ??
                                                      '',
                                                  'jumlahJamban':
                                                      keluarga.jumlahJamban ??
                                                      '',
                                                  'sumberAir':
                                                      keluarga.sumberAir ?? '',
                                                  'tempatSampah':
                                                      keluarga.tempatSampah ??
                                                      '',
                                                  'saluranAirLimbah':
                                                      keluarga
                                                          .saluranAirLimbah ??
                                                      '',
                                                  'stikerP4k':
                                                      keluarga.stikerP4k ?? '',
                                                  'kriteriaRumah':
                                                      keluarga.kriteriaRumah ??
                                                      '',
                                                  'aktivitasUp2k':
                                                      keluarga.aktivitasUp2k ??
                                                      '',
                                                  'jenisUsaha':
                                                      keluarga.jenisUsaha ?? '',
                                                  'aktivitasKesehatan':
                                                      keluarga
                                                          .aktivitasKesehatan ??
                                                      '',
                                                  'namaKrtPerkarangan':
                                                      keluarga
                                                          .namaKrtPerkarangan ??
                                                      '',
                                                  'namaKrtIndustri':
                                                      keluarga
                                                          .namaKrtIndustri ??
                                                      '',
                                                  'berkebutuhanKhusus':
                                                      keluarga
                                                          .berkebutuhanKhusus ??
                                                      '',
                                                  'anggotaKeluarga':
                                                      keluarga
                                                          .anggotaKeluarga ??
                                                      '',
                                                  'pemanfaatanTanah':
                                                      keluarga
                                                          .pemanfaatanTanah ??
                                                      '',
                                                  'industriKeluarga':
                                                      keluarga
                                                          .industriKeluarga ??
                                                      '',
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
                                                  keluarga.nama,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  keluarga.mawar,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            keluarga.jumlah,
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
