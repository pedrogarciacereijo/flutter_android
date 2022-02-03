import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Styles.dart';
import 'home_page.dart';

class GamePage extends StatefulWidget {
  
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static String letra;
  int contadorLetrasCorrectas;
  int contadorAciertos;

  @override
  void initState() {
    super.initState();
    contadorAciertos = 0;
    contadorLetrasCorrectas = 0;
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

  List<SizedBox> createButtons(String letra) {
    List<SizedBox> buttonList = new List<SizedBox>.filled(9, null);

    for (var i = 0; i <= 8; i++) {
      buttonList[i] = SizedBox(
        width: MediaQuery.of(context).size.width * 0.09,
        height: MediaQuery.of(context).size.height * 0.09,
        child: SizedBox.expand(
          child: Button(letra, elegirLetra(letra)),
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
    } else {
      contadorLetrasCorrectas++;
    }
    return aux;
  }

  void aumentarContadorAciertos(){
    contadorAciertos++;
  }

  void restartGame(){
    setState(() {});
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
              ListTile(
                leading: Icon(Icons.refresh, color: Styles.foregroundColor),
                title: Text('Restart Game', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 200), () => restartGame());
                },
              ),

              ListTile(
                  leading: Icon(Icons.arrow_back_rounded,
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
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: () => showOptionModalSheet(context),
                      ),
                    ],
                  ),
            ),
            body: Builder(builder: (builder) {
              return SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: createRows(letra),
                ),
              );
            }),
            ));
  }
}

class Button extends StatefulWidget {
  String letra;
  String text;

  Button(String letra, String text){
    this.letra = letra;
    this.text = text;
  }

  UpdateButtonState createState() => UpdateButtonState();

}

class UpdateButtonState extends State<Button> {
  final gamepage = _GamePageState();

  List<Color> _colors = <Color>[
    Colors.grey,
    Colors.red,
    Colors.green
  ];

  int _currentColorIndex = 0;

  void changeColorIndex(String letra, String text) {
    setState(() {
      if (letra == text) {
        _currentColorIndex = 2;
        gamepage.aumentarContadorAciertos();
      } else {
        _currentColorIndex = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: TextButton(
            onPressed: () => {changeColorIndex(widget.letra, widget.text)},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(_colors[_currentColorIndex]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.red)
                  )
              )
            ),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        )
    );
  }

}