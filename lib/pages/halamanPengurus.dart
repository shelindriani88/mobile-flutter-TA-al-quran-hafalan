import 'package:flutter/material.dart';
import 'package:hafalan_quran/model/DB-Helper.dart';
//import 'package:hafalan_quran/model/FadeAnimation.dart';
import 'package:hafalan_quran/model/surat.dart';
//import 'package:hafalan_quran/model/presentase.dart';
import 'package:hafalan_quran/pages/isi-ayat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';


class HalamanPengurus extends StatefulWidget {
  @override
  _HalamanPengurusState createState() => _HalamanPengurusState();
}

class _HalamanPengurusState extends State<HalamanPengurus> {
  List<Data> dataSurat;
  List<Data> presentage;
  List<Data> benar;
  List<Data> salah;
  DBHelper dbHelper;
  List<Presentase> listPresentase=List<Presentase>();

  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<Quote> getSurat() async {
    String api = "https://al-quran-8d642.firebaseio.com/data.json?print=pretty";
    final response = await http.get(api);

    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      getPresentase();
      return Quote.fromJson(response.body);
    } else {
      return null;
    }
  }

  Widget _listSurat(String suratke, String namaSurat, int jumlahAyat,
    String typeSurat, String namaSuratArab, String persenHalafan,Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Card(
        elevation: 1.0,
        color: const Color(0xFFFFFFFF),
        //nosurat
        child: new ListTile(
          leading: Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[300]
              ),
            child: Align(
              alignment: Alignment.center,  
              child: Text(
                suratke,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text(
                namaSurat + " | ",
                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                namaSuratArab,
                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
           trailing: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              margin: EdgeInsets.all(5),
              height: 30,
              width: 30,
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  persenHalafan,
                  style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            ),
          ),
          subtitle: new Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: new Text(
              typeSurat + " | " + jumlahAyat.toString(),
              style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )));
  }
  Future<List> getPresentase()async{
    Future<List<Presentase>> list=dbHelper.getPresentase();
    list.then((list){
      if(list.length>0){

       for(int i=0;i<list.length;i++){
         listPresentase.add(Presentase(
           nomorSurat: list[i].nomorSurat,
           presentase: list[i].presentase,
           jumlahayatSurat: list[i].jumlahayatSurat
         ));
       }
      }
    });

  }

  @override
  void initState() {
    dbHelper=DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: new Text(
          "Daftar Surat",
        ),
      ),
      backgroundColor: Colors.green[100],
      body: FutureBuilder<Quote>(
        future: getSurat(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Data> data = snapshot.data.data;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, int i) {
                int suratke = i + 1;
                int persen=0;
                if(listPresentase.length!=null){
                  for(int j=0;j<listPresentase.length;j++){
                    if(suratke==listPresentase[j].nomorSurat){
                      persen=listPresentase[j].presentase.floor();
                    }
                  }
                }else{
                  persen=0;
                }

              if(persen>=0 && persen<=35){
                return InkWell(
                    onTap: (){
                      print("print surat ke $suratke" );
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiAyat(suratke: suratke,namaSurat: data[i].namaSurat,jumlahAyat: data[i].jumlahAyat,)));
                    },
                    child: _listSurat(
                        suratke.toString(),
                        data[i].namaSurat,
                        data[i].jumlahAyat,
                        data[i].typeSurat,
                        data[i].namaSuratArab,
                        "${persen.toString()}%",Colors.grey[400]));
              }else if(persen>35 && persen<=75){
                return InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiAyat(suratke: suratke,namaSurat: data[i].namaSurat,)));
                    },
                    child: _listSurat(
                        suratke.toString(),
                        data[i].namaSurat,
                        data[i].jumlahAyat,
                        data[i].typeSurat,
                        data[i].namaSuratArab,
                        "${persen.toString()} %",Colors.orange[400]));
              }else{
                return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IsiAyat(suratke: suratke,namaSurat: data[i].namaSurat,)));
                    },
                    child: _listSurat(
                        suratke.toString(),
                        data[i].namaSurat,
                        data[i].jumlahAyat,
                        data[i].typeSurat,
                        data[i].namaSuratArab,
                        "${persen.toString()}%",Colors.yellow[400]));
                }
              }
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}
 
class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border),
        color: Colors.green[900],
      onPressed: () {},
    );
  }
}
