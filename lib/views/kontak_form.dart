import 'package:flutter/material.dart';
import '../controllers/kontak_form_controller.dart';
import '../services/kontak_storage_service.dart';

class KontakFormPage extends StatefulWidget {
  const KontakFormPage({super.key});

  @override
  State<KontakFormPage> createState() =>
      _KontakFormPageState();
}

class _KontakFormPageState extends State<KontakFormPage> {
  final controller = KontakFormController(
    storage: KontakStorageService(),
  );

  final namaController = TextEditingController();
  final noHpController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    noHpController.dispose();
    alamatController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
      ),

      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informasi Siswa',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),


                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Siswa',
                    hintText: 'Masukkan nama siswa',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: noHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP Orang Tua',
                    hintText: 'Masukkan nomor HP',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: alamatController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    hintText: 'Masukkan alamat siswa',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                if (controller.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: Text(
                      controller.errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: controller.loading
                        ? null
                        : () async {
                            final berhasil =
                                await controller.tambahKontak(
                              namaController.text,
                              noHpController.text,
                              alamatController.text,
                            );

                            if (!context.mounted) return;

                            if (berhasil) {
                              Navigator.pop(context, true);
                            }
                          },

                    icon: controller.loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.person_add),

                    label: Text(
                      controller.loading
                          ? 'Menyimpan...'
                          : 'Tambah Kontak',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
