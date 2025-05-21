import 'package:flutter/material.dart';
import 'donation_history_page.dart';
import 'profile_page.dart';
import 'campaign_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomeContent(),         // Halaman utama kampanye
    const DonationHistoryPage(), // Riwayat donasi
    const ProfilePage(),         // Profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kampanye Donasi'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Fungsi pencarian
            },
          ),
        ],
      ),
      body: const CampaignListPage(),
    );
  }
}

class CampaignListPage extends StatelessWidget {
  const CampaignListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return CampaignCard(
          campaignId: index + 1,
        );
      },
    );
  }
}

class CampaignCard extends StatelessWidget {
  final int campaignId;

  const CampaignCard({
    super.key,
    required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    // Data kampanye
    final List<String> campaignTitles = [
      'Kampanye Air Bersih',
      'Kampanye Bantuan Banjir',
      'Kampanye Pengobatan Kanker',
      'Kampanye Pendidikan Anak',
      'Kampanye Perbaikan Sekolah',
    ];
    
    final List<String> campaignDescriptions = [
      'Bantu menyediakan akses air bersih untuk desa-desa terpencil yang masih kesulitan mendapatkan air layak konsumsi.',
      'Bantuan untuk korban banjir yang kehilangan tempat tinggal dan harta benda akibat bencana alam.',
      'Bantuan pengobatan untuk pasien kanker dari keluarga tidak mampu agar mendapatkan perawatan yang layak.',
      'Dukung pendidikan anak-anak kurang mampu agar tetap bisa bersekolah dan meraih cita-cita mereka.',
      'Bantu perbaikan sekolah rusak di daerah terpencil agar anak-anak dapat belajar dengan nyaman.',
    ];

    final title = campaignTitles[campaignId - 1];
    final description = campaignDescriptions[campaignId - 1];
    final progress = campaignId * 0.2;
    final targetAmount = 10000000.0;
    final collectedAmount = campaignId * 2000000.0;

    // Daftar path gambar sesuai index
    final List<String> imagePaths = [
      'assets/images/campaignairbersih.jpg',
      'assets/images/campaignbanjir.jpg',
      'assets/images/campaignkanker.jpg',
      'assets/images/campaignpendidikan.jpg',
      'assets/images/campaignperbaikan.jpg',
    ];

    // Path gambar untuk kampanye ini
    final imagePath = imagePaths[campaignId - 1];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CampaignDetailPage(
                title: title,
                description: description,
                imagePath: imagePath,
                targetAmount: targetAmount,
                collectedAmount: collectedAmount,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tampilkan gambar sesuai urutan kampanye
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 180,
                    child: Center(child: Text('Gagal memuat gambar')),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp${collectedAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp${targetAmount.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}