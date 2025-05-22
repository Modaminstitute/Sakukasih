import 'package:flutter/material.dart';
import 'package:jejakdonaturapp/screens/register_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo aplikasi dari assets
            Image.asset(
              'assets/icon/sakukasihlogo.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 24),
            const Text(
              'SakuKasih',
              style: TextStyle(
                color: Color(0xFF441F95),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Donasi mudah, cepat, dan aman',
              style: TextStyle(
                color: Color(0xFF441F95),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}