
//import 'package:hafalan_quran/model/presentase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
class DBHelper{
  static String _path;
  static  Database _database;
  static final DB_NAME="hafalan.db";
  static final _DB_VERSION=1;
  static final COLUMN_NOMOR_SURAT="nomor_surat";
  static final COLUMN_PERSENSTASE="persentase";
  static final COLUMN_JUMLAH_AYAT="jumlah_ayat";
  static final TABLE_NAME="presentase";

  Future<Database> get db async{
    if(_database!=null){
      return _database;
    }
    _database=await initDB();
    return _database;
  }

  initDB()async {
    io.Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,DB_NAME);
    var db=await openDatabase(path,version: _DB_VERSION,onCreate: _onCreate);
    return db;

  }


  Future _onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NOMOR_SURAT INTEGER,$COLUMN_JUMLAH_AYAT INTEGER,$COLUMN_PERSENSTASE DOUBLE)');


  }

  Future<void> save(int nomorSurat,int jumlahayatSurat,int jumlahAyat)async{



    var dbClient =await db;

    List findsurat=await dbClient.rawQuery("SELECT * FROM $TABLE_NAME WHERE $COLUMN_NOMOR_SURAT= ?",['$nomorSurat']);
    if(findsurat.length==0){
      int ayat=1;
      double presentase=(ayat/jumlahayatSurat)*100;
      await dbClient.transaction((tnx)async{

       return await tnx.rawInsert('INSERT INTO $TABLE_NAME ($COLUMN_NOMOR_SURAT,$COLUMN_JUMLAH_AYAT,$COLUMN_PERSENSTASE) VALUES(?,?,?)',
           ["$nomorSurat","$jumlahAyat","$presentase"]);

      });


    }else{
      int jumlahAyat=0;
      int nomor_surat;
      for(int i=0;i<findsurat.length;i++){
        jumlahAyat=findsurat[i]['jumlah_ayat']+1;
        nomorSurat=findsurat[i]['nomor_surat'];
      }

      double presentase=(jumlahAyat/jumlahayatSurat)*100;
      if(presentase>100){
        presentase=100.0;
      }

       return await dbClient.rawUpdate('UPDATE $TABLE_NAME SET $COLUMN_JUMLAH_AYAT = ?, $COLUMN_PERSENSTASE  = ? WHERE $COLUMN_NOMOR_SURAT= ? ', ["$jumlahAyat","$presentase","$nomorSurat"]);

    }


  }
  Future<List<Presentase>> getPresentase()async{
  var dbClient=await db;
  List<Map> maps=await dbClient.rawQuery('SELECT * FROM $TABLE_NAME');
  List<Presentase> presentase=[];

  if(maps.length>0){
    for(int i=0;i<maps.length;i++){
      print(maps.toString());
      presentase.add(Presentase.fromMap(maps[i]));
    }
  }
  return presentase;
  }
}

class Presentase {
  int nomorSurat;
  int jumlahayatSurat;
  double presentase;

  Presentase({this.nomorSurat, this.jumlahayatSurat, this.presentase});

  Presentase.fromMap(Map<String,dynamic> map){
    nomorSurat = map['nomor_surat'];
    jumlahayatSurat = map['jumlah_ayat'];
    presentase = map['persentase'];
  }
}


