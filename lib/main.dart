import 'package:flutter/material.dart';

// Tambahkan semua import halaman
import 'screens/register_page.dart';
import 'screens/campaign_detail_page.dart';
import 'screens/donation_page.dart';
import 'screens/donation_history_page.dart';
import 'screens/profile_page.dart';
import 'screens/donation_update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jejak Donatur',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegisterPage(),
      routes: {
        '/home': (context) => const RegisterPage(),
        '/campaign-detail': (context) => const CampaignDetailPage(),
        '/donation': (context) => const DonationPage(),
        '/history': (context) => const DonationHistoryPage(),
        '/profile': (context) => const ProfilePage(),
        '/donation-update': (context) => const UpdateInfoPage()
      },
    );
  }
}
