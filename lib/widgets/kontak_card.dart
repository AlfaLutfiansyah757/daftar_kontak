import 'package:flutter/material.dart';
import '../models/daftar_kontak.dart';

class KontakCard extends StatelessWidget {
  final DaftarKontak kontak;
  final VoidCallback onTap;

  const KontakCard({
    super.key,
    required this.kontak,
    required this.onTap,
  });

  String get inisial {
    List<String> kata = kontak.nama.trim().split(' ');

    if (kata.length == 1) {
      return kata[0][0].toUpperCase();
    }

    return '${kata[0][0]}${kata[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            inisial,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          kontak.nama,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(kontak.noHp),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
