class DaftarKontak {
    final int id;
    final String nama;
    final String noHp;
    final String alamat;

    DaftarKontak({
        required this.id,
        required this.nama,
        required this.noHp,
        required this.alamat,
    });

    factory DaftarKontak.fromJson(Map<String, dynamic> json) {
        return DaftarKontak(
            id: json['id'],
            nama: json['nama'],
            noHp: json['noHp'],
            alamat: json['alamat',]
        );
    }
}