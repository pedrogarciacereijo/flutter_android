import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Styles.dart';
import 'home_page.dart';

class GamePage extends StatefulWidget {
  
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static String letra;
  static String text;

  @override
  void initState() {
    super.initState();
    
  }

  List<SizedBox> createButtons(String letra) {
    List<SizedBox> buttonList = new List<SizedBox>.filled(9, null);

    for (var i = 0; i <= 8; i++) {

      text = elegirLetra(letra);
      buttonList[i] = SizedBox(
        width: 38,
        height: 38,
        child: SizedBox.expand(
          child: Button(),
        )
      );
    }

    return buttonList;
  }

  String generarLetraAleatoria(int len) {
    var r = Random();
    const _chars = 'bdmnpq';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  String elegirLetra(String letra) {
    String aux = letra;
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    if (randomNumber > 50){
      switch (letra) {
        case 'b':
          aux = 'd';
          break;
        case 'd':
          aux = 'b';
          break;
        case 'm':
          aux = 'n';
          break;
        case 'n':
          aux = 'm';
          break;
        case 'p':
          aux = 'q';
          break;
        case 'q':
          aux = 'p';
          break;
      }
    }
    return aux;
  }

  Row oneRow(String letra) {
    return Row(
      children: createButtons(letra),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<Row> createRows(String letra) {
    List<Row> rowList = new List<Row>.filled(9, null);
    for (var i = 0; i <= 8; i++) {
      rowList[i] = oneRow(letra);
    }
    return rowList;
  }

  showOptionModalSheet(BuildContext context) {
    BuildContext outerContext = context;
    showModalBottomSheet(
        context: context,
        backgroundColor: Styles.secondaryBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          final TextStyle customStyle =
          TextStyle(inherit: false, color: Styles.foregroundColor);
          return Wrap(
            children: [
              /*ListTile(
                leading: Icon(Icons.refresh, color: Styles.foregroundColor),
                title: Text('Restart Game', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 200), () => restartGame());
                },
              ),*/

              ListTile(
                leading: Icon(Icons.lightbulb_outline_rounded,
                    color: Styles.foregroundColor),
                title: Text('Salir', style: customStyle),
                onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HomePage()))
              )
            ]
          );
        },

          );
        }

  @override
  Widget build(BuildContext context) {
    letra = generarLetraAleatoria(1);
    return new WillPopScope(
        child: new Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: AppBar(
                    centerTitle: true,
                    title: Text('Encuentra todas las letras ' + letra),
                    backgroundColor: Colors.blueGrey[900],
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.minimize_outlined),
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 15),

                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        padding: EdgeInsets.fromLTRB(8, 8, 20, 8),

                      ),
                    ],
                  ),
            ),
            body: Builder(builder: (builder) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: createRows(letra),
                ),
              );
            }),
            floatingActionButton: FloatingActionButton(
              foregroundColor: Styles.primaryBackgroundColor,
              backgroundColor: Styles.primaryColor,
              onPressed: () => showOptionModalSheet(context),
              child: Icon(Icons.menu_rounded),
            )));
  }
}

class Button extends StatefulWidget {

  UpdateButtonState createState() => UpdateButtonState();

}

class UpdateButtonState extends State {

  List<Color> _colors = <Color>[
    Colors.grey,
    Colors.red,
    Colors.green
  ];

  int _currentColorIndex = 0;

  String get letra => _GamePageState.letra;

  String get text => _GamePageState.text;

  void changeColorIndex(String letra, String text) {
    setState(() {
      if (letra == text) {
        _currentColorIndex = 2;
      } else {
        _currentColorIndex = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
                onPressed: () => {changeColorIndex(letra, text)},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(_colors[_currentColorIndex]),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
    );
  }

}