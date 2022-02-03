import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tfg/models/authentication.dart';

import 'home_page.dart';

class RegistrarseScreen extends StatefulWidget {
  _RegistrarseScreenState createState() => _RegistrarseScreenState();
}

class _RegistrarseScreenState extends State<RegistrarseScreen>{
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

    final registrarseButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // Get username and password from the user.Pass the data to helper method

          AuthenticationHelper()
              .registrarse(email: _email.text, password: _password.text)
              .then((result) {
            if (result == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  result,
                  style: TextStyle(fontSize: 16),
                ),
              ));
            }
          });
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('REGISTRARSE', style: TextStyle(color: Colors.white)),
      ),
    );

    final iniciarSesionLabel = FlatButton(
      child: Text(
        'Si ya tienes una cuenta, inicia sesión',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/iniciarSesion');
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
                  registrarseButton,
                  iniciarSesionLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}