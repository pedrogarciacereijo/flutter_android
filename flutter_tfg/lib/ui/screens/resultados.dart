import 'package:flutter/material.dart';

class ResultadosScreen extends StatelessWidget {
  static const routeName = '/resultados';

  final int letrasCorrectas;
  final int aciertos;
  final int fallos;

  ResultadosScreen({Key key, @required this.letrasCorrectas, @required this.aciertos, @required this.fallos}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final aciertosLabel = Text(
        "Has acertado $aciertos de $letrasCorrectas\n Fallos: $fallos",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 36.0, color: Colors.black54),
    );

    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('¿Quieres volver al menú principal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/homePage')),
              child: new Text('Sí'),
            ),
          ],
        ),
      )) ?? false;
    }

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 48.0),
                      aciertosLabel,
                      SizedBox(height: 24.0)

                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}


