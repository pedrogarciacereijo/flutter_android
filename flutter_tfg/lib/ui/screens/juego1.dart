import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tfg/models/ejercicio.dart';
import '../../controller/firestore.dart';
import 'package:flutter_tfg/models/tipoEjercicio.dart';
import 'package:flutter_tfg/ui/screens/resultados.dart';

class GamePage1 extends StatefulWidget {
  final int nivel;

  const GamePage1({Key key, this.nivel}) : super(key: key);

  @override
  _GamePage1State createState() => _GamePage1State();
}

class _GamePage1State extends State<GamePage1> {
  static String letra;
  ValueNotifier<bool> _notifier = ValueNotifier(false);

  DateTime dateInicio;
  DateTime dateFin;
  int contadorLetrasCorrectas;
  int contadorAciertos;
  int contadorErrores;

  @override
  void initState() {
    super.initState();
    dateInicio = DateTime.now();
    contadorAciertos = 0;
    contadorErrores = 0;
    contadorLetrasCorrectas = 0;
  }

  Row oneRow(String letra, nivel) {
    return Row(
      children: createButtons(letra, nivel),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<Row> createRows(String letra, int nivel) {
    List<Row> rowList = new List<Row>.filled(nivel, null);
    for (var i = 0; i <= nivel-1; i++) {
      rowList[i] = oneRow(letra, nivel);
    }
    return rowList;
  }

  List<SizedBox> createButtons(String letra, int nivel) {
    List<SizedBox> buttonList = new List<SizedBox>.filled(nivel, null);

    for (var i = 0; i <= nivel-1; i++) {
      buttonList[i] = SizedBox(
        width: MediaQuery.of(context).size.width * (1/(nivel+1)),
        height: MediaQuery.of(context).size.height * (1/(nivel+1)),
        child: SizedBox.expand(
            child: Button(letra: letra, text: elegirLetra(letra), onClicked: aumentarContadores)
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

  void aumentarContadores(bool){
    if(bool){
      contadorAciertos++;
      print("Contador Aciertos: " + contadorAciertos.toString());
    } else {
      contadorErrores++;
      print("Contador Errores: " + contadorErrores.toString());
    }
  }

  void restartGame(){
    setState(() {
      contadorAciertos = 0;
      contadorLetrasCorrectas = 0;
    });
  }

  Future<void> endGame() async {
    dateFin = DateTime.now();

    String userId = (await FirebaseAuth.instance.currentUser).email;


    Ejercicio ejercicio = Ejercicio(userId, dateFin: dateFin, dateInicio: dateInicio,
                          tipoEjercicio: 'ejercicioLetras', dificultad: dificultadEjercicioLetras(widget.nivel),
                          errores: contadorErrores, aciertos: contadorAciertos, letrasCorrectas: contadorLetrasCorrectas);

    FirestoreHelper().addEjercicio(ejercicio);
    //Usuario usuario = await FirestoreHelper().getUsuario();
    //print(usuario.toString());
    //Map<String, dynamic> json = usuario.toJson();
    //json['ejercicios'].append(ejercicio.toJson());
    //FirestoreHelper().updateUsuario(usuario);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadosScreen(letrasCorrectas: this.contadorLetrasCorrectas, aciertos: this.contadorAciertos, fallos: this.contadorErrores,),
        )
    );
  }

  @override
  void dispose() {  //Esto está aquí por el notifier (Para liberar memoria)
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    letra = generarLetraAleatoria(1);
    return new Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: AppBar(
                    centerTitle: true,
                    title: Text('Encuentra todas las letras ' + letra),
                    backgroundColor: Colors.blueGrey[900],
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          endGame();
                        }
                      ),
                    ],
                  ),
            ),
            body: Builder(builder: (builder) {
              return SizedBox.expand(
                    child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: createRows(letra, widget.nivel),
                        ),
              );

            }),
    );
  }
}

class Button extends StatefulWidget {
  final String letra;
  final String text;
  final Function onClicked;

  const Button({Key key, @required this.onClicked, this.letra, this.text}) : super(key: key);

  UpdateButtonState createState() => UpdateButtonState();

}

class UpdateButtonState extends State<Button> {
  final gamepage = _GamePage1State();

  int _currentColorIndex = 0;
  bool _isButtonDisabled = false;

  void initState(){
    super.initState();
    _currentColorIndex = 0;
  }

  List<Color> _colors = <Color>[
    Colors.grey,
    Colors.red,
    Colors.green
  ];

  void buttonPressed(String letra, String text) {
    if(!_isButtonDisabled){
      setState(() {
        if (letra == text) {
          _currentColorIndex = 2;
          widget.onClicked(true);
        } else {
          _currentColorIndex = 1;
          widget.onClicked(false);
        }
        _isButtonDisabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: TextButton(
            onPressed: () => {buttonPressed(widget.letra, widget.text)},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(_colors[_currentColorIndex]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Theme.of(context).highlightColor)
                  )
              )
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          )
        )
    );
  }
}