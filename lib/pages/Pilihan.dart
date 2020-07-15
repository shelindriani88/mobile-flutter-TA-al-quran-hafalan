import 'package:flutter/material.dart';
import 'package:hafalan_quran/model/FadeAnimation.dart';
import 'loginOrangtua.dart';
import 'loginPengurus.dart';

class Pilihan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
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
                Container(
                  child: Text("Login Sebagai :",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.right),
                  //margin: EdgeInsets.only(top: 50),
                  // padding: EdgeInsets.all(10.0),
                  // child: TextField(
                  //   decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       hintText: "Ustadz/Guru :",
                  //       hintStyle: TextStyle(color: Colors.grey[400])),
                  // ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: SizedBox(
                    width: 290.0,
                    height: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //side: BorderSide(color: Colors.white),
                      ),
                      color: Color.fromRGBO(143, 148, 251, 1),
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPengurus()));
                      },
                      child: Text('Ustadz/Guru'),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                ),
                Container(
                  child: SizedBox(
                    width: 290.0,
                    height: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //side: BorderSide(color: Colors.white),
                      ),
                      color: Color.fromRGBO(143, 148, 251, 1),
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginOrangtua()));
                      },
                      child: Text('Orangtua Santri'),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                ),
              ],
            ),
          ),
        ));
  }
}

// class Pilihan extends StatefulWidget {
//   @override
//   _PilihanState createState() => _PilihanState();
// }

// class _PilihanState extends State<Pilihan> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Container(
//         child: Column(
//         children: <Widget>[
//           RaisedButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(105),
//               side: BorderSide(color: Colors.white),
//             ),
//             color: Colors.lightGreen[800],
//             textColor: Colors.white,
//             onPressed: () {
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => HalamanPengurus()));
//             },
//             child: Text('Hafalan'),
//           ),
//           RaisedButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(105),
//               side: BorderSide(color: Colors.white),
//             ),
//             color: Colors.lightGreen[800],
//             textColor: Colors.white,
//             onPressed: () {
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => HalamanPengurus()));
//             },
//             child: Text('Hafalan'),
//           ),
//         ],
//       )),
//     );
//   }
// }
