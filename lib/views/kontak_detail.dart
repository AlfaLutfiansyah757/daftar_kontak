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
    String inisial = kontak.nama.trim().split(' ').length > 1
        ? kontak.nama.trim().split(' ').take(2).map((e) => e[0]).join().toUpperCase()
        : kontak.nama[0].toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F8FA),
        elevation: 0,
        title: const Text(
          'Detail Kontak',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF172C36),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 42,
              backgroundColor: const Color(0xFFDDEFE9),
              child: Text(
                inisial,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF347C6C),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              kontak.nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172C36),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Kontak Orang Tua Siswa',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF71838A),
              ),
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Informasi Kontak',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172C36),
                ),
              ),
            ),

            const SizedBox(height: 12),

            informasiCard(
              icon: Icons.badge_outlined,
              judul: 'ID Siswa',
              isi: kontak.id.toString(),
            ),

            informasiCard(
              icon: Icons.phone_outlined,
              judul: 'Nomor Telepon',
              isi: kontak.noHp,
            ),

            informasiCard(
              icon: Icons.location_on_outlined,
              judul: 'Alamat',
              isi: kontak.alamat,
            ),
          ],
        ),
      ),
    );
  }

  Widget informasiCard({
    required IconData icon,
    required String judul,
    required String isi,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: const BorderSide(
          color: Color(0xFFDCE7E5),
        ),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),

        leading: CircleAvatar(
          backgroundColor: const Color(0xFFDDEFE9),
          child: Icon(
            icon,
            color: const Color(0xFF347C6C),
          ),
        ),

        title: Text(
          judul,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF71838A),
          ),
        ),

        subtitle: Text(
          isi,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172C36),
          ),
        ),
      ),
    );
  }
}
