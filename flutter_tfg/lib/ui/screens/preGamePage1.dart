import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'juego1.dart';

class PreGamePage1 extends StatefulWidget {
  PreGamePage1({Key key}) : super(key: key);

  @override
  _PreGamePage1State createState() => _PreGamePage1State();
}

class _PreGamePage1State extends State<PreGamePage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.blueGrey[900]],
            stops: [0.8, 1.0]),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(height: 30.0),
                Text(
                  "ELIGE EL NIVEL",
                  style: TextStyle(
                  fontFamily: "Comix-Loud",
                  color: Colors.white,
                  fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.0),
                Column(
                    children: <Widget>[
                        Padding(padding:EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => GamePage1(nivel: 3))),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("FÁCIL",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 20.0)),
                                          Text(
                                              "Un tablero de 3x3")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(padding:EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => GamePage1(nivel: 6))),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("MEDIO",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 20.0)),
                                          Text(
                                              "Un tablero de 6x6")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(padding:EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => GamePage1(nivel: 9))),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("DIFICIL",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 20.0)),
                                          Text(
                                              "Un tablero de 9x9")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ]
                )
              ]
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ]
        )
      ),
    );
  }
}