import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DonationGoodsPage extends StatefulWidget {
  const DonationGoodsPage({super.key});

  @override
  State<DonationGoodsPage> createState() => _DonationGoodsPageState();
}

class _DonationGoodsPageState extends State<DonationGoodsPage> {
  int step = 0;

  // Step 1: Lokasi
  String? selectedLocation;
  final List<String> locations = ['Jakarta', 'Bandung', 'Surabaya'];

  // Step 2: Mitra
  String? selectedMitra;
  final Map<String, List<String>> mitraByLocation = {
    'Jakarta': ['Mitra A', 'Mitra B'],
    'Bandung': ['Mitra C'],
    'Surabaya': ['Mitra D', 'Mitra E'],
  };

  // Step 3: Pengiriman
  String? pengiriman; // 'Diambil' atau 'Kirim Sendiri'

  // Step 4: Form Barang
  final TextEditingController namaBarangController = TextEditingController();
  String? kategoriBarang;
  String? kondisiBarang;
  final TextEditingController deskripsiController = TextEditingController();
  XFile? fotoBarang;
  final TextEditingController alamatController = TextEditingController();

  // Step 5: Ringkasan

  final List<String> kategoriList = [
    'Pakaian',
    'Elektronik',
    'Buku',
    'Peralatan Rumah Tangga',
    'Lainnya'
  ];
  final List<String> kondisiList = [
    'Baru',
    'Bekas Layak Pakai',
    'Bekas Tidak Layak'
  ];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        fotoBarang = picked;
      });
    }
  }

  void nextStep() {
    setState(() {
      step++;
    });
  }

  void prevStep() {
    setState(() {
      step--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donasi Barang'),
        backgroundColor: const Color(0xFF441F95),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: step,
          controlsBuilder: (context, details) {
            return Row(
              children: [
                if (step > 0)
                  TextButton(
                    onPressed: prevStep,
                    child: const Text('Kembali'),
                  ),
                const SizedBox(width: 8),
                if (step < 4)
                  ElevatedButton(
                    onPressed: () {
                      if (step == 0 && selectedLocation == null) return;
                      if (step == 1 && selectedMitra == null) return;
                      if (step == 2 && pengiriman == null) return;
                      if (step == 3 &&
                          (namaBarangController.text.isEmpty ||
                              kategoriBarang == null ||
                              kondisiBarang == null ||
                              deskripsiController.text.isEmpty ||
                              (pengiriman == 'Diambil' &&
                                  alamatController.text.isEmpty))) {
                        return;
                      }
                      nextStep();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF441F95)),
                    child: const Text('Selanjutnya'),
                  ),
                if (step == 4)
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Donasi Terkirim'),
                          content: const Text(
                              'Terima kasih, donasi barang Anda telah dikirim!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              child: const Text('Tutup'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF441F95)),
                    child: const Text('Kirim Donasi'),
                  ),
              ],
            );
          },
          steps: [
            Step(
              title: const Text('Pilih Lokasi'),
              isActive: step >= 0,
              content: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Lokasi Anda',
                  border: OutlineInputBorder(),
                ),
                value: selectedLocation,
                items: locations
                    .map((loc) =>
                        DropdownMenuItem(value: loc, child: Text(loc)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedLocation = val;
                    selectedMitra = null;
                  });
                },
              ),
            ),
            Step(
              title: const Text('Pilih Mitra Terdekat'),
              isActive: step >= 1,
              content: selectedLocation == null
                  ? const Text('Pilih lokasi terlebih dahulu.')
                  : DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Mitra Pengumpulan',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedMitra,
                      items: (mitraByLocation[selectedLocation] ?? [])
                          .map((mitra) => DropdownMenuItem(
                              value: mitra, child: Text(mitra)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedMitra = val;
                        });
                      },
                    ),
            ),
            Step(
              title: const Text('Pilih Metode Pengiriman'),
              isActive: step >= 2,
              content: Column(
                children: [
                  RadioListTile<String>(
                    value: 'Diambil',
                    groupValue: pengiriman,
                    onChanged: (val) => setState(() => pengiriman = val),
                    title: const Text('Barang dijemput ke alamat saya'),
                  ),
                  RadioListTile<String>(
                    value: 'Kirim Sendiri',
                    groupValue: pengiriman,
                    onChanged: (val) => setState(() => pengiriman = val),
                    title: const Text('Saya akan mengirimkan barang sendiri'),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Detail Barang'),
              isActive: step >= 3,
              content: Column(
                children: [
                  TextField(
                    controller: namaBarangController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Barang',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Kategori Barang',
                      border: OutlineInputBorder(),
                    ),
                    value: kategoriBarang,
                    items: kategoriList
                        .map((k) =>
                            DropdownMenuItem(value: k, child: Text(k)))
                        .toList(),
                    onChanged: (val) => setState(() => kategoriBarang = val),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Kondisi Barang',
                      border: OutlineInputBorder(),
                    ),
                    value: kondisiBarang,
                    items: kondisiList
                        .map((k) =>
                            DropdownMenuItem(value: k, child: Text(k)))
                        .toList(),
                    onChanged: (val) => setState(() => kondisiBarang = val),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Singkat',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: pickImage,
                        icon: const Icon(Icons.upload),
                        label: const Text('Upload Foto Barang'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF441F95)),
                      ),
                      const SizedBox(width: 12),
                      if (fotoBarang != null)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  if (fotoBarang != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        // ignore: use_build_context_synchronously
                        File(fotoBarang!.path),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (pengiriman == 'Diambil') ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: alamatController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat Pengambilan',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ],
              ),
            ),
            Step(
              title: const Text('Ringkasan Donasi'),
              isActive: step >= 4,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lokasi: $selectedLocation'),
                  Text('Mitra: $selectedMitra'),
                  Text('Pengiriman: $pengiriman'),
                  Text('Nama Barang: ${namaBarangController.text}'),
                  Text('Kategori: $kategoriBarang'),
                  Text('Kondisi: $kondisiBarang'),
                  Text('Deskripsi: ${deskripsiController.text}'),
                  if (fotoBarang != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.file(
                        File(fotoBarang!.path),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (pengiriman == 'Diambil')
                    Text('Alamat Pengambilan: ${alamatController.text}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}