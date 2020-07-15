import 'dart:convert' as convert;

class Quote {
  final String author;
  final String quote;
  final List<Data> data;

  Quote({this.author, this.quote, this.data});
  factory Quote.fromJson(String json) {
    var jsonData=convert.jsonDecode(json);
    var list=jsonData as List;

    print("json" + list.toString());
    List<Data> data = list.map((i) => Data.fromJson(i)).toList();

    return Quote(author: "Sapa bae", quote: "success", data: data);
  }
}
//bagian daftar surat
class Data {
  final String namaSurat;
  final String typeSurat;
  final int jumlahAyat;
  final String namaSuratArab;

  Data({this.namaSurat, this.typeSurat, this.jumlahAyat, this.namaSuratArab});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      namaSurat: json['nama'],
      typeSurat: json['type'],
      jumlahAyat: json['ayat'],
      namaSuratArab: json['asma']);
  }
}
