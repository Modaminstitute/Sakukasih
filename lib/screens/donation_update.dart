import 'package:flutter/material.dart';

class UpdateInfoPage extends StatelessWidget {
  const UpdateInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> updates = [
      {
        'tanggal': '10 Mei 2025',
        'judul': 'Distribusi Tahap 1 Selesai',
        'deskripsi':
            'Dana donasi telah digunakan untuk membeli kebutuhan pokok dan didistribusikan ke 100 penerima manfaat.'
      },
      {
        'tanggal': '5 Mei 2025',
        'judul': 'Penggalangan Dana Dimulai',
        'deskripsi':
            'Kami memulai kampanye donasi untuk mendukung masyarakat terdampak bencana di wilayah X.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Info Donasi'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: updates.length,
        itemBuilder: (context, index) {
          final update = updates[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    update['judul']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    update['tanggal']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(update['deskripsi']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
