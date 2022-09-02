import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tfg/models/ejercicio.dart';
import 'package:flutter_tfg/models/firestore.dart';
import 'package:flutter_tfg/models/tipoEjercicio.dart';
import 'package:flutter_tfg/ui/screens/resultados.dart';

class GamePage2 extends StatefulWidget {
  final int nivel;

  const GamePage2({Key key, this.nivel}) : super(key: key);

  @override
  _GamePage2State createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2> {
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

  List<Row> createRows(String letra, int nivel, int desplazamiento, int direccion) {
    List<Row> rowList = new List<Row>.filled(nivel, null);
    for (var i = 0; i <= nivel-1; i++) {
      rowList[i] = oneRow(letra, nivel, desplazamiento, direccion);
    }
    return rowList;
  }

  Row oneRow(String letra, int nivel, int desplazamiento, int direccion) {
    return Row(
      children: createButtons(letra, nivel, desplazamiento, direccion),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<SizedBox> createButtons(String letra, int nivel, int desplazamiento, int direccion) {
    List<SizedBox> buttonList = new List<SizedBox>.filled(nivel, null);
    var arr = new List.filled(nivel, false);
    var arrText = new List.generate(nivel, (int index) => elegirLetra());

    for (var i = 0; i <= nivel-1; i++) {
      String text = arrText[i];

      if (text == letra){
        if(direccion == 0){             // Si el desplazamiento es hacia la derecha
          int aux = i + desplazamiento;
          if(aux < nivel){
            arr[aux] = true;
            contadorLetrasCorrectas++;
          }
        }
        if(direccion == 1){             // Si el desplazamiento es hacia la izquierda
          if(desplazamiento <= i){
            int aux = i - desplazamiento;
            if(aux >= 0){
              arr[aux] = true;
              contadorLetrasCorrectas++;
            }
            buttonList[aux] = SizedBox(   // Es necesario reconstruir el botón al estar a la izquierda
                width: MediaQuery.of(context).size.width * (1/(nivel+1)),
                height: MediaQuery.of(context).size.height * (1/(nivel+1)),
                child: SizedBox.expand(
                    child: Button(activado: arr[aux], text: arrText[aux], onClicked: aumentarContadores)
                )
            );
          }
        }
      }

      buttonList[i] = SizedBox(
          width: MediaQuery.of(context).size.width * (1/(nivel+1)),
          height: MediaQuery.of(context).size.height * (1/(nivel+1)),
          child: SizedBox.expand(
              child: Button(activado: arr[i], text: arrText[i], onClicked: aumentarContadores)
          )
      );
    }
    print(arr);
    return buttonList;
  }

  int generarDireccion() {
    Random random = new Random();
    int randomNumber = random.nextInt(2); //Devuelve un número random de entre 0 a 1
    return randomNumber;
  }

  int generarDesplazamiento(int nivel){
    Random random = new Random();
    int randomNumber = 1 + random.nextInt(nivel-1); //Devuelve un número random de entre 1 al nivel-1
    return randomNumber;
  }

  String elegirLetra() {
    var r = Random();
    const _chars = 'aeiou';
    return List.generate(1, (index) => _chars[r.nextInt(_chars.length)]).join();
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


  Future<void> endGame() async {
    dateFin = DateTime.now();

    String userId = (await FirebaseAuth.instance.currentUser).email;


    Ejercicio ejercicio = Ejercicio(userId, dateFin: dateFin, dateInicio: dateInicio,
        tipoEjercicio: 'ejercicioDesplazamiento', dificultad: dificultadEjercicioLetras(widget.nivel),
        errores: contadorErrores, aciertos: contadorAciertos, letrasCorrectas: contadorLetrasCorrectas);

    FirestoreHelper().addEjercicio(ejercicio);

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

    String letra = elegirLetra();
    int desplazamiento = generarDesplazamiento(widget.nivel);
    int direccion = generarDireccion();
    String textDireccion = (direccion == 0) ? 'derecha' : 'izquierda';  // Si direccion == 0, es hacia la derecha, si es 1, es hacia la izquierda

    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: ListTile(
            title:
            Text('Encuentra todas las letras ' + desplazamiento.toString(), style: TextStyle(color:Colors.white)),
            subtitle:
            Text('posiciones a la ' + textDireccion + ' de las "'+ letra + '"', style: TextStyle(color:Colors.white)),
          ),
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
            children: createRows(letra, widget.nivel, desplazamiento, direccion),
          ),
        );

      }),
    );
  }
}

class Button extends StatefulWidget {
  final bool activado;
  
  final String text;
  final Function onClicked;

  const Button({Key key, @required this.onClicked, this.activado, this.text}) : super(key: key);

  UpdateButtonState createState() => UpdateButtonState();

}

class UpdateButtonState extends State<Button> {
  final gamepage = _GamePage2State();

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

  void buttonPressed(bool activado, String text) {
    if(!_isButtonDisabled){
      setState(() {
        if (activado) {
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
              onPressed: () => {buttonPressed(widget.activado, widget.text)},
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