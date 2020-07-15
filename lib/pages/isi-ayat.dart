import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hafalan_quran/model/DB-Helper.dart';
import 'dart:convert' as convert;
import 'package:hafalan_quran/model/ayat.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class IsiAyat extends StatefulWidget {
  final suratke;
  final namaSurat;
  final jumlahAyat;
  final artiAyat;

  const IsiAyat({Key key, this.suratke, this.namaSurat, this.jumlahAyat, this.artiAyat}) : super(key: key);
  @override
  _ListAyatState createState() => _ListAyatState(this.suratke,this.namaSurat,this.jumlahAyat);
}

class _ListAyatState extends State<IsiAyat> {
  List<Data> dataAyat;
  final suratke;
  final namaSurat;
  int jumlahAyat;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Color textColor=Colors.black;
  Color backGroundColor=Colors.white;
  DBHelper dbHelpers;

  Future<Quote> getAyat(String suratke) async {
    String api = "https://al-quran-8d642.firebaseio.com/surat/"+suratke+".json?print=pretty";
    final response = await http.get(api);

    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      return Quote.fromJson(response.body);
    } else {
      return null;
    }
  }
  


  Widget _listAyat(String ayatke, String ayatArab,
    String artiAyat, String bunyiAyat) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Card(
        elevation: 1.0,
        color: backGroundColor,
        child: new ListTile(
          leading: Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300]),
            child: Align(
              alignment: Alignment.center ,
              child: Text(
                ayatke,
                textAlign: TextAlign.center,
              )
            ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text(
               ayatArab.length > 15 ? ".."+ ayatArab.substring(0,15) : ayatArab,
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0,color: textColor),overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,
                // textAlign: TextAlign.right,
              ),
            ],
          ),
          subtitle: new Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: new Text(
              artiAyat,
              style: new TextStyle(color: textColor, fontSize: 15.0),
            )
          ),
        )));
  }
  // method dialog untuk logout
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hafalan Qur'an"),
          content: new Text("Apakah anda yakin sudah hafal ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ya"),
              onPressed: () {
                Navigator.of(context).pop();
                _saveHalafan();
              },
            ),
            new FlatButton(
              child: new Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _ListAyatState(this.suratke, this.namaSurat, this.jumlahAyat);


  @override
  void initState() {

    dbHelpers=DBHelper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surat " +namaSurat),
        backgroundColor: Colors.green[900],
      ),
      key: scaffoldKey,
      backgroundColor: Colors.green[100],
      body: FutureBuilder<Quote>(
        future: getAyat("$suratke"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Data> data = snapshot.data.data;
            jumlahAyat=data.length;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, int i) {
                int ayatke = i + 1;

                return InkWell(
                  onTap: (){
                    _showDialog();
                  },
                    onDoubleTap: (){
                      showModalBottomSheet(context: context, builder: (BuildContext context){
                        return SingleChildScrollView(
                          child: Container(

                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text("Ayat Ke  $ayatke",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                  ),

                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    data[i].ayatArab,
                                    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),textAlign: TextAlign.right,
                                    // textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Html(
                                    data: data[i].bunyiAyat,
                                  ),),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text( "Artinya:",
                                        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),textAlign: TextAlign.left,
                                        // textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        data[i].artiAyat,
                                        style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),textAlign: TextAlign.left,
                                        // textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    onLongPress: (){
                      showModalBottomSheet(context: context, builder: (BuildContext context){
                        return SingleChildScrollView(
                          child: Container(

                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text("Ayat Ke  $ayatke",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                  ),

                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    data[i].ayatArab,
                                    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),textAlign: TextAlign.right,
                                    // textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Html(
                                    data: data[i].bunyiAyat,
                                  ),),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text( "Artinya:",
                                        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),textAlign: TextAlign.left,
                                        // textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        data[i].artiAyat,
                                        style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),textAlign: TextAlign.left,
                                        // textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  child: _listAyat(
                    ayatke.toString(),
                    data[i].ayatArab,
                    data[i].artiAyat,
                    data[i].bunyiAyat,
                  )
                );
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

  void _saveHalafan() async{
    print("jumlah ayat" + jumlahAyat.toString());

   dbHelpers.save(suratke, jumlahAyat, 1);
  }
}
