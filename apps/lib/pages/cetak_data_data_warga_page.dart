import 'package:flutter/material.dart';
import 'preview_data_warga_page.dart';

class CetakDataWargaPage extends StatelessWidget {
  const CetakDataWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> wargaData = [
      {'nama': 'Budi Utomo', 'mawar': 'Mawar 1', 'nik': '3276273271'},
      {'nama': 'Joko Putro', 'mawar': 'Mawar 2', 'nik': '3276273271'},
      {'nama': 'Agus Setiadi', 'mawar': 'Mawar 2', 'nik': '3276273271'},
      {'nama': 'Slamet Rudi', 'mawar': 'Mawar 1', 'nik': '3276273271'},
      {'nama': 'Lanange Jagad', 'mawar': 'Mawar 3', 'nik': '3276273271'},
      {'nama': 'Soeharto', 'mawar': 'Mawar 1', 'nik': '3276273271'},
      {'nama': 'Tri Hadi', 'mawar': 'Mawar 2', 'nik': '3276273271'},
      {'nama': 'Lala Sari', 'mawar': 'Mawar 1', 'nik': '3278273271'},
      {'nama': 'Rina Dewi', 'mawar': 'Mawar 3', 'nik': '3278273271'},
    ];

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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF3D5A99), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.people, color: Colors.white, size: 25),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pilih data warga yang ingin dijadikan PDF', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ...wargaData.map((warga) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PreviewDataWargaPage(wargaData: warga)),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(color: const Color(0xFFE8E8E8), borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(warga['nama']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                                            const SizedBox(height: 4),
                                            Text(warga['mawar']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                          ],
                                        ),
                                      ),
                                      Text(warga['nik']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              )),
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