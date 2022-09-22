import 'package:flutter/material.dart';
import '../../../controller/authentication.dart';
import '../../../controller/firestore.dart';

class IniciarSesionScreen extends StatefulWidget {
  _IniciarSesionScreenState createState() => _IniciarSesionScreenState();
}

class _IniciarSesionScreenState extends State<IniciarSesionScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      //validator: Validator.validateEmail,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      //validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: Colors.black54)
                )
            )
        ),
        onPressed: () {
          // Se comprueba si el usuario está autorizado para iniciar sesión
          // (existe en la base de datos porque ha sido creado anteriormente por un admin)
          usuarioAutorizadoInicioSesion();

        },
        child: Text('INICIAR SESIÓN', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/recuperarPassword');
      },
    );

    final signUpLabel = TextButton(
      child: Text(
        'Crea una cuenta',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/registrarse');
      },
    );

    return Scaffold(
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
                      email,
                      SizedBox(height: 24.0),
                      password,
                      SizedBox(height: 12.0),
                      loginButton,
                      forgotLabel,
                      signUpLabel
                    ],
                  ),
                ),
              ),
            ),
          ),
      );
  }

  void usuarioAutorizadoInicioSesion() async{
    bool aux = await FirestoreHelper().comprobarUsuarioAutorizado(_email.text);
    AuthenticationHelper().iniciarSesion(email: _email.text, password: _password.text).then((result) {
      if (result == null) {
          print(aux);
          if (aux){
            Navigator.pushNamed(context, '/homePage');
          }else{
            AuthenticationHelper().cerrarSesion();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Este usuario no está autorizado para iniciar sesión. SI ya tenías una cuenta, es posible que el administrador te haya dado de baja",
                style: TextStyle(fontSize: 16),
              ),
            ));
          };
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });
  }

}

