import 'package:flutter/material.dart';

import '../models/daftar_kontak.dart';
import '../services/json_service.dart';
import '../widgets/kontak_card.dart';
import 'kontak_detail.dart';

class KontakListPage extends StatefulWidget {
  const KontakListPage({super.key});

  @override
  State<KontakListPage> createState() => _KontakListPageState();
}

class _KontakListPageState extends State<KontakListPage> {
  final JsonService jsonService = JsonService();

  List<DaftarKontak> daftarKontak = [];

  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    muatKontak();
  }

  Future<void> muatKontak() async {
    try {
      List<DaftarKontak> data =
          await jsonService.ambilKontak();

      setState(() {
        daftarKontak = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kontak XI RPL'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Total: ${daftarKontak.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error.isNotEmpty
              ? Center(
                  child: Text('Gagal memuat data: $error'),
                )
              : daftarKontak.isEmpty
                  ? const Center(
                      child: Text('Belum ada kontak siswa'),
                    )
                  : ListView.builder(
                      itemCount: daftarKontak.length,
                      itemBuilder: (context, index) {
                        final kontak = daftarKontak[index];

                        return KontakCard(
                          kontak: kontak,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return KontakDetailPage(
                                    kontak: kontak,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
