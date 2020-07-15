import 'dart:convert' as convert;

//mengolah data json
class Quote {
  final String author;
  final String quote;
  final List<Data> data;

  Quote({this.author, this.quote, this.data});
  factory Quote.fromJson(String json) {
    var jsonData=convert.jsonDecode(json);
    var list=jsonData as List;
    List<Data> data = list.map((i) => Data.fromJson(i)).toList();

    return Quote(author: "Sapa bae", quote: "success", data: data);
  }
}

//didalam model ayat ini terdapat kelas yg akan menjadi blueprint dari isi al-qur'an
// data yg diambil dari api https://github.com/bachors/Al-Quran-ID-API
// kelas Data ini untuk menyimpan data
class Data {
  final String ayatArab;
  final String artiAyat;
  final String bunyiAyat;
//pemanggilan
  Data({this.ayatArab, this.artiAyat,this.bunyiAyat});
//data json
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      //yang ada di api
      ayatArab: json['ar'],
      artiAyat: json['id'],
      bunyiAyat: json['tr']);
  }
}
