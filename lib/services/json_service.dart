import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/daftar_kontak.dart';

class JsonService {
  Future<List<DaftarKontak>> ambilKontak() async {
    final String response = await rootBundle.loadString(
      'assets/data/kontak.json',
    );

    final List<dynamic> data = jsonDecode(response);

    return data.map((item) {
      return DaftarKontak.fromJson(item);
    }).toList();
  }
}
