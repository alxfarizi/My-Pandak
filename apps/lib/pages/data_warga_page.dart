import 'package:flutter/material.dart';
import 'tambah_data_warga_page.dart';

class DataWargaPage extends StatelessWidget {
  const DataWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> wargaData = [
      {'nama': 'Budi Utomo', 'mawar': 'Mawar 1', 'nik': '3278273271'},
      {'nama': 'Joko Putro', 'mawar': 'Mawar 2', 'nik': '3276273271'},
      {'nama': 'Agus Setiadi', 'mawar': 'Mawar 2', 'nik': '3276273271'},
      {'nama': 'Slamet Rudi', 'mawar': 'Mawar 1', 'nik': '3278273271'},
      {'nama': 'Lonange Jagad', 'mawar': 'Mawar 3', 'nik': '3278273271'},
      {'nama': 'Soeharto', 'mawar': 'Mawar 1', 'nik': '3276273271'},
      {'nama': 'Tri Hadi', 'mawar': 'Mawar 2', 'nik': '3278273271'},
      {'nama': 'Lala Sari', 'mawar': 'Mawar 1', 'nik': '3278273271'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        actions: [
          Container(margin: const EdgeInsets.only(right: 20), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF3D5A99), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.people, color: Colors.white, size: 25))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Data Warga', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TambahDataWargaPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Tambah Data'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  ),
                ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      ...wargaData.map((warga) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: const Color(0xFFE8E8E8), borderRadius: BorderRadius.circular(8)),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(warga['nama']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                                  const SizedBox(height: 4),
                                  Text(warga['mawar']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                ]),
                              ),
                              Text(warga['nik']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            ]),
                          )),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
