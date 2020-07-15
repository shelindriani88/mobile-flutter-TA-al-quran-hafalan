import 'package:flutter/material.dart';
import 'package:hafalan_quran/model/FadeAnimation.dart';
import 'loginPengurus.dart';

class LupaPassword extends StatelessWidget {
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: TextField(
                    obscureText: true,
                    maxLength: 7,
                    decoration: InputDecoration(
                      //hintText: "Enter Your code",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                      labelText: "Masukkan Email Anda",
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20.0))
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: SizedBox(
                    width: 130.0,
                    height: 35.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
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
                      child: Text('Forget Password'),
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
