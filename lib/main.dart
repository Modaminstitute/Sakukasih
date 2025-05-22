import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Tambahkan semua import halaman
import 'screens/register_page.dart';
import 'screens/campaign_detail_page.dart';
import 'screens/donation_page.dart';
import 'screens/donation_history_page.dart';
import 'screens/profile_page.dart';
import 'screens/donation_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://uijbguofxgkjfknnojul.supabase.co', // <-- replace with your Supabase project URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpamJndW9meGdramZrbm5vanVsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyMDA0ODIsImV4cCI6MjA2Mjc3NjQ4Mn0.vzVuko2ebpS32j4lcrMbgJ_g0eLPG1wfZl7xMsGpdT0', // <-- replace with your anon/public API key
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/donation-update': (context) => const UpdateInfoPage(),
      },
    );
  }
}
