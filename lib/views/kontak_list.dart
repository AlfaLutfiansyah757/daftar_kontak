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
  String kataKunci = '';

  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    muatKontak();
  }

  Future<void> muatKontak() async {
    try {
      List<DaftarKontak> data = await jsonService.ambilKontak();

      if (!mounted) return;

      setState(() {
        daftarKontak = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  List<DaftarKontak> get kontakFilter {
    return daftarKontak.where((kontak) {
      return kontak.nama.toLowerCase().contains(
            kataKunci.toLowerCase(),
          ) ||
          kontak.noHp.contains(kataKunci) ||
          kontak.alamat.toLowerCase().contains(
            kataKunci.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F8FA),
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Buku Kontak XI RPL',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172C36),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFDDEFE9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${daftarKontak.length} Kontak',
              style: const TextStyle(
                color: Color(0xFF267565),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      kataKunci = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari nama, nomor HP, atau alamat',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF588F82),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD5E2E1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD5E2E1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF72B5A4),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFD5E2E1),
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Text(
                      'Kelas XI RPL',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF426F66),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : error.isNotEmpty
                    ? Center(
                        child: Text('Gagal memuat kontak: $error'),
                      )
                    : kontakFilter.isEmpty
                        ? const Center(
                            child: Text('Kontak tidak ditemukan'),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 18,
                              right: 18,
                              bottom: 15,
                            ),
                            itemCount: kontakFilter.length,
                            itemBuilder: (context, index) {
                              final kontak = kontakFilter[index];

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
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        height: 65,
        backgroundColor: const Color(0xFFEAF2EF),
        indicatorColor: const Color(0xFFC6E8DC),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index != 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Menu ini belum tersedia'),
              ),
            );

            setState(() {
              selectedIndex = 1;
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.contacts_outlined),
            label: 'Kontak',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            label: 'Rapat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
