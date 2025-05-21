import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {
  int _selectedAmount = 0;
  String _selectedMethod = 'Transfer Bank';

  final List<int> _amountOptions = [50000, 100000, 200000, 500000, 1000000];
  final List<String> _paymentMethods = ['Transfer Bank', 'E-Wallet'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Nominal Donasi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _amountOptions.map((amount) {
                return ChoiceChip(
                  label: Text('Rp${amount.toString()}'),
                  selected: _selectedAmount == amount,
                  onSelected: (selected) {
                    setState(() {
                      _selectedAmount = selected ? amount : 0;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nominal Lainnya',
                prefixText: 'Rp',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _selectedAmount = int.tryParse(value) ?? 0;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: _paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: _selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedMethod = value!;
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAmount > 0
                    ? () {
                  // Simpan data donasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Donasi berhasil disimpan!'),
                    ),
                  );
                  Navigator.pop(context);
                }
                    : null,
                child: const Text('Konfirmasi Donasi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}