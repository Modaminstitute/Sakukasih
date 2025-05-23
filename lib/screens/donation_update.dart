import 'package:flutter/material.dart';

class UpdateInfoPage extends StatelessWidget {
  const UpdateInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy, bisa diganti dengan data asli dari backend
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

    final List<Map<String, String>> impacts = [
      {
        'icon': 'volunteer_activism',
        'title': '100 Penerima Manfaat',
        'desc': 'Bantuan telah disalurkan ke 100 orang.'
      },
      {
        'icon': 'school',
        'title': '20 Anak Sekolah',
        'desc': 'Menerima perlengkapan belajar baru.'
      },
      {
        'icon': 'local_hospital',
        'title': 'Bantuan Medis',
        'desc': 'Obat-obatan dan alat kesehatan telah didistribusikan.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Donasi & Laporan'),
        backgroundColor: const Color(0xFF441F95),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Ringkasan Donasi
          Card(
            color: Colors.purple.shade50,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total Donasi Terkumpul',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Rp 10.000.000',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF441F95)),
                  ),
                  SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: 0.8,
                    color: Color(0xFF441F95),
                    backgroundColor: Colors.purpleAccent,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '80% dari target Rp 12.500.000',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Transparansi Penggunaan Dana
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Transparansi Penggunaan Dana',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('• Rp 7.000.000 untuk kebutuhan pokok'),
                  Text('• Rp 2.000.000 untuk perlengkapan sekolah'),
                  Text('• Rp 1.000.000 untuk bantuan medis'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Dampak Bantuan
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dampak Bantuan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ...impacts.map((impact) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          _iconFromString(impact['icon']!),
                          color: const Color(0xFF441F95),
                        ),
                        title: Text(
                          impact['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(impact['desc']!),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Riwayat Update Donasi
          const Text(
            'Riwayat Update Donasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...updates.map((update) => Card(
                margin: const EdgeInsets.only(bottom: 12),
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
              )),
        ],
      ),
    );
  }

  static IconData _iconFromString(String iconName) {
    switch (iconName) {
      case 'volunteer_activism':
        return Icons.volunteer_activism;
      case 'school':
        return Icons.school;
      case 'local_hospital':
        return Icons.local_hospital;
      default:
        return Icons.info_outline;
    }
  }
}