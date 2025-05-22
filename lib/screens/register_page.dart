import 'package:flutter/material.dart';
import 'package:jejakdonaturapp/screens/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _registerUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Pastikan email tidak ada spasi
      final email = emailController.text.trim();
      final password = passwordController.text;
      final name = nameController.text.trim();

      // Validasi sederhana email
      if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Format email tidak valid')),
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Sign up the user with email and password
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      final user = response.user;

      if (user != null) {
        // Insert additional user info into the 'users' table
        await Supabase.instance.client.from('users').insert({
          'id': user.id,
          'name': name,
          'email': email,
        });

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Buat Akun Baru',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Kata Sandi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: _registerUser,
                      child: const Text(
                        'Daftar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}