import 'package:flutter/material.dart';
import 'package:jejakdonaturapp/screens/donation_update.dart';

class DonationHistoryPage extends StatelessWidget {
  const DonationHistoryPage({super.key});

  final List<Map<String, dynamic>> _donationHistory = const [
    {
      'title': 'Donasi untuk Kampanye 1',
      'amount': 'Rp100.000',
    },
    {
      'title': 'Donasi untuk Kampanye 2',
      'amount': 'Rp200.000',
    },
    {
      'title': 'Donasi untuk Kampanye 3',
      'amount': 'Rp300.000',
    },
    {
      'title': 'Donasi untuk Kampanye 4',
      'amount': 'Rp400.000',
    },
    {
      'title': 'Donasi untuk Kampanye 5',
      'amount': 'Rp500.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Donasi'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _donationHistory.length,
        itemBuilder: (context, index) {
          final donation = _donationHistory[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.purpleAccent,
                    child: Icon(Icons.attach_money, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          donation['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          donation['amount'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const UpdateInfoPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline, size: 18),
                          label: const Text("Lihat Update Info"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
