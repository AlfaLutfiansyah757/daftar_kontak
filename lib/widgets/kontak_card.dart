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
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFFDCE7E5),
        ),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),

        leading: CircleAvatar(
          radius: 21,
          backgroundColor: const Color(0xFFDDEFE9),
          child: Text(
            inisial,
            style: const TextStyle(
              color: Color(0xFF347C6C),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          kontak.nama,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172C36),
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${kontak.noHp} • ${kontak.alamat}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF71838A),
            ),
          ),
        ),

        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFF428D7D),
          size: 20,
        ),

        onTap: onTap,
      ),
    );
  }
}
