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
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Transfer Bank',
      'icon': Icons.account_balance,
      'desc': 'Transfer ke rekening bank resmi yayasan.'
    },
    {
      'name': 'E-Wallet',
      'icon': Icons.account_balance_wallet,
      'desc': 'Dukung dengan OVO, GoPay, Dana, dll.'
    },
    {
      'name': 'QRIS',
      'icon': Icons.qr_code_2,
      'desc': 'Scan QRIS untuk donasi instan.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donasi'),
        backgroundColor: Color(0xFF441F95),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pilih Nominal Donasi',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _amountOptions.map((amount) {
                          return ChoiceChip(
                            label: Text('Rp${amount.toString()}'),
                            selected: _selectedAmount == amount,
                            selectedColor: Colors.purple.shade100,
                            onSelected: (selected) {
                              setState(() {
                                _selectedAmount = selected ? amount : 0;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nominal Lainnya',
                          prefixText: 'Rp',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _selectedAmount = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pilih Metode Pembayaran',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ..._paymentMethods.map((method) {
                        return Column(
                          children: [
                            RadioListTile<String>(
                              value: method['name'],
                              groupValue: _selectedMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedMethod = value!;
                                });
                              },
                              title: Row(
                                children: [
                                  Icon(method['icon'], color:Color(0xFF441F95)),
                                  const SizedBox(width: 10),
                                  Text(method['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              subtitle: Text(method['desc']),
                            ),
                            if (method['name'] == 'QRIS' && _selectedMethod == 'QRIS')
                              Padding(
                                padding: const EdgeInsets.only(left: 40, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.purple.shade200),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                        'assets/images/qris_example.png',
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) => const Center(child: Text('QRIS')),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Scan QRIS di atas dengan aplikasi pembayaran Anda.',
                                      style: TextStyle(fontSize: 13, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            const Divider(height: 1),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Konfirmasi Donasi', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF441F95),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _selectedAmount > 0
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Donasi berhasil disimpan!'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}