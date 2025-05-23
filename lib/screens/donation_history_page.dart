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
        backgroundColor:Color(0xFF441F95),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _donationHistory.length,
        itemBuilder: (context, index) {
          final donation = _donationHistory[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.purple.shade100,
                    child: const Icon(Icons.volunteer_activism, color:Color(0xFF441F95), size: 30),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          donation['title'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on, color: Colors.green, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              donation['amount'],
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 22, thickness: 1),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF441F95),
                              side: const BorderSide(color: Color(0xFF441F95)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
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
                          ),
                        ),
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