import 'package:flutter/material.dart';
import 'package:hafalan_quran/model/FadeAnimation.dart';
import 'package:hafalan_quran/pages/halamanPengurus.dart';
import 'lupaPassword.dart';

class DataKelas extends StatefulWidget {
  @override
  _DataKelasState createState() => _DataKelasState();
}

class _DataKelasState extends State<DataKelas> {
  String title = 'DropDownButton';
  List _friendVal;
  List _friendName = ['Kelas A', 'Kelas B', 'Kelas C', 'Kelas D'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.3,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.5,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              child: Text("Daftar Kelas :",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.start),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1), width: 2.0),
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: DropdownButton(
                hint: Text('Select One'),
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                isExpanded: true,
                value: _friendVal,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                onChanged: (value) {
                  setState(() {
                    _friendVal = value;
                  });
                },
                items: _friendName.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            new Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HalamanPengurus()));
                },
                child: Text(
                  'see',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
