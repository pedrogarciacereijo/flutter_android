import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tfg/ui/screens/preGamePage2.dart';

import '../../models/authentication.dart';
import 'autenticacion/iniciarSesion.dart';
import 'preGamePage1.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime pre_backpress = DateTime.now();

  Future<bool> onWillPop() async{
    final timegap = DateTime.now().difference(pre_backpress);
    final cantExit = timegap >= Duration(seconds: 2);
    pre_backpress = DateTime.now();
    if(cantExit){
      //show snackbar
      final snack = SnackBar(content: Text('Pulsa otra vez el botón para salir'),duration: Duration(seconds: 2),);
      ScaffoldMessenger.of(context).showSnackBar(snack);
      return false; // false will do nothing when back press
    }else{
      SystemNavigator.pop();
      return true;   // true will exit the app
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
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
                        "ELIGE LA ACTIVIDAD",
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
                                  MaterialPageRoute(builder: (_) => PreGamePage1())),
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
                                            Text("Diferenciar Letras",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 20.0)),
                                            Text(
                                                "Encuentra todas las letras indicadas")
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
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => PreGamePage2())),
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
                                            Text("Encontrar con Desplazamiento",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 20.0)),
                                            Text(
                                                "Encuentra todas las letras que se encuentren a la derecha o a la izquierda de la letra indicada")
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
                                              Text("Más actividades en el futuro...",
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
                      icon: Icon(Icons.logout),
                      color: Colors.white,
                      onPressed: () => _cerrarSesion(context),
                    ),
                  ),
                ],
              )),
        )
    );
  }
}

void _cerrarSesion(BuildContext context) {
  AuthenticationHelper().cerrarSesion();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => IniciarSesionScreen(),
    ),
  );
}