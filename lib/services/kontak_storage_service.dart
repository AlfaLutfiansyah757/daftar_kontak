import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/daftar_kontak.dart';

class KontakStorageService {
  static const String storageKey = 'daftar_kontak';

  Future<List<DaftarKontak>> loadKontak() async {
    final prefs = await SharedPreferences.getInstance();

    final dataTersimpan = prefs.getString(storageKey);

    if (dataTersimpan != null) {
      final List data = jsonDecode(dataTersimpan);

      return data.map((item) {
        return DaftarKontak.fromJson(item);
      }).toList();
    }

    final response = await rootBundle.loadString(
      'assets/data/kontak.json',
    );

    final List data = jsonDecode(response);

    return data.map((item) {
      return DaftarKontak.fromJson(item);
    }).toList();
  }

  Future<void> saveKontak(List<DaftarKontak> kontak) async {
    final prefs = await SharedPreferences.getInstance();

    final data = kontak.map((item) {
      return {
        'id': item.id,
        'nama': item.nama,
        'noHp': item.noHp,
        'alamat': item.alamat,
      };
    }).toList();

    await prefs.setString(
      storageKey,
      jsonEncode(data),
    );
  }
}
