import 'package:flutter/material.dart';
import 'preview_data_keluarga_page.dart';

class CetakDataKeluargaPage extends StatelessWidget {
  const CetakDataKeluargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> keluargaData = [
      {'nama': 'Budi Utomo', 'mawar': 'Mawar 1', 'jumlah': '1'},
      {'nama': 'Joko Putro', 'mawar': 'Mawar 2', 'jumlah': '2'},
      {'nama': 'Agus Setiadi', 'mawar': 'Mawar 2', 'jumlah': '1'},
      {'nama': 'Slamet Rudi', 'mawar': 'Mawar 1', 'jumlah': '2'},
      {'nama': 'Lanange Jagad', 'mawar': 'Mawar 3', 'jumlah': '3'},
      {'nama': 'Soeharto', 'mawar': 'Mawar 1', 'jumlah': '1'},
      {'nama': 'Tri Hadi', 'mawar': 'Mawar 2', 'jumlah': '3'},
      {'nama': 'Lala Sari', 'mawar': 'Mawar 1', 'jumlah': '1'},
      {'nama': 'Rina Dewi', 'mawar': 'Mawar 3', 'jumlah': '3'},
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
        title: const Text('Cetak Data Keluarga', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.home_filled, color: Colors.white, size: 25),
          )
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
                child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Pilih data keluarga yang ingin dijadikan PDF', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 15),
                ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      ...keluargaData.map((keluarga) => GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewDataKeluargaPage(keluargaData: keluarga)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: const Color(0xFFE8E8E8), borderRadius: BorderRadius.circular(8)),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(keluarga['nama']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                                    const SizedBox(height: 4),
                                    Text(keluarga['mawar']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                  ]),
                                ),
                                Text(keluarga['jumlah']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ]),
                            ),
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