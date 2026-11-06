import 'package:flutter/material.dart';

import '../models/daftar_kontak.dart';
import '../services/kontak_storage_service.dart';

class KontakFormController extends ChangeNotifier {
  final KontakStorageService storage;

  KontakFormController({
    required this.storage,
  });

  bool loading = false;

  String? errorMessage;

  bool validasi(String nama, String noHp, String alamat) {
    if (nama.trim().isEmpty ||
        noHp.trim().isEmpty ||
        alamat.trim().isEmpty) {
      errorMessage = 'Semua data harus diisi';
      notifyListeners();
      return false;
    }

    errorMessage = null;
    return true;
  }

  Future<bool> tambahKontak(
    String nama,
    String noHp,
    String alamat,
  ) async {
    if (!validasi(nama, noHp, alamat)) {
      return false;
    }

    loading = true;
    notifyListeners();

    try {
      List<DaftarKontak> daftarKontak =
          await storage.loadKontak();

      int idBaru = 1;

      for (var kontak in daftarKontak) {
        if (kontak.id >= idBaru) {
          idBaru = kontak.id + 1;
        }
      }

      DaftarKontak kontakBaru = DaftarKontak(
        id: idBaru,
        nama: nama.trim(),
        noHp: noHp.trim(),
        alamat: alamat.trim(),
      );

      daftarKontak.add(kontakBaru);

      await storage.saveKontak(daftarKontak);

      loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      errorMessage = 'Gagal menambahkan kontak';

      loading = false;
      notifyListeners();

      return false;
    }
  }

  Future<bool> hapusKontak(int id) async {
    loading = true;
    notifyListeners();

    try {
      List<DaftarKontak> daftarKontak =
          await storage.loadKontak();

      daftarKontak.removeWhere(
        (kontak) => kontak.id == id,
      );

      await storage.saveKontak(daftarKontak);

      loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      errorMessage = 'Gagal menghapus kontak';

      loading = false;
      notifyListeners();

      return false;
    }
  }
}
