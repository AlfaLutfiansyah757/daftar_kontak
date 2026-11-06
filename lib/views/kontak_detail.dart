import 'package:flutter/material.dart';
import '../models/daftar_kontak.dart';

class KontakDetailPage extends StatelessWidget {
  final DaftarKontak kontak;

  const KontakDetailPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kontak'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            CircleAvatar(
              radius: 45,
              child: Text(
                kontak.nama[0].toUpperCase(),
                style: const TextStyle(fontSize: 30),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              kontak.nama,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Nomor Telepon'),
                subtitle: Text(kontak.noHp),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Alamat'),
                subtitle: Text(kontak.alamat),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('ID Siswa'),
                subtitle: Text(kontak.id.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
