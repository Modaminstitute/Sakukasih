import 'package:flutter/material.dart';
import 'package:jejakdonaturapp/screens/donation_goods_page.dart';
import 'package:jejakdonaturapp/screens/donation_page.dart';
import 'package:share_plus/share_plus.dart';

class CampaignDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double targetAmount;
  final double collectedAmount;

  const CampaignDetailPage({
    super.key,
    this.title = 'Kampanye Default', // Berikan nilai default
    this.description = 'Deskripsi default kampanye',
    this.imagePath = 'assets/images/campaignairbersih.jpg',
    this.targetAmount = 10000000,
    this.collectedAmount = 5000000,
  });

  @override
  Widget build(BuildContext context) {
    double progress = collectedAmount / targetAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kampanye'),
        backgroundColor:Color(0xFF441F95),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan gambar kampanye
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Text('Gagal memuat gambar: $imagePath'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Judul kampanye
              Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              // Deskripsi kampanye
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              
              const Text(
                'Update Terbaru:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              
              const BulletList(items: [
                "Update terbaru tentang perkembangan kampanye",
                "Informasi tambahan",
                "Kabar baik dari penerima donasi"
              ]),
              const SizedBox(height: 24),
              
              // Progress bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.purple.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF441F95)),
                minHeight: 12,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 8),
              
              Text(
                'Terkumpul: Rp${collectedAmount.toInt()} dari Target: Rp${targetAmount.toInt()}',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              
              // Tombol donasi dana & barang
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DonationPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF441F95),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Donasi Dana',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DonationGoodsPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.card_giftcard, color: Color(0xFF441F95)),
                      label: const Text(
                        'Donasi Barang',
                        style: TextStyle(color: Color(0xFF441F95), fontSize: 16),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF441F95)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Tombol Bagikan
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.share, color:Color(0xFF441F95)),
                  label: const Text(
                    'Bagikan Kampanye',
                    style: TextStyle(color: Color(0xFF441F95), fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF441F95)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final shareText =
                        'Ayo dukung kampanye "$title"!\n\n$description\n\nTarget: Rp${targetAmount.toInt()}\nTerkumpul: Rp${collectedAmount.toInt()}';
                    Share.share(shareText);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 16, color: Colors.black87)),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}