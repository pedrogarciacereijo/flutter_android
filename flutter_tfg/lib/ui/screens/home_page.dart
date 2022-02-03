import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Juego1.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    "ELIGE EL JUEGO",
                    style: TextStyle(
                        fontFamily: "Comix-Loud",
                        color: Colors.white,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.0),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                        EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => GamePage())),
                          child: Row(
                            children: <Widget>[
                              /*Container(
                                width: 75.0,
                                height: 75.0,
                                child: Image.asset("assets/images/cheers.png"),
                              ),*/
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
                                        Text("JUEGO 1",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 20.0)),
                                        Text(
                                            "Explicacion del juego 1")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          //onTap: () => onModeSelected(Mode.KINKY),
                          child: Opacity(
                            opacity: 0.3,
                            child: Row(
                              children: <Widget>[
                                /*Container(
                                    width: 75.0,
                                    height: 75.0,
                                    child:
                                        Image.asset("assets/images/mouth.png")),*/
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("JUEGO 2",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 20.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.arrowLeft),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          )),
    );
  }
}