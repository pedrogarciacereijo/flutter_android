import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controller/authentication.dart';

class RecuperarPassword extends StatelessWidget {
  final TextEditingController _email = new TextEditingController();

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

    void _recuperarPassword({String email, BuildContext context}) async {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      try {
        await AuthenticationHelper().recuperarPassword(email);
        Flushbar(
          title: "Correo enviado",
          message:
          'Sigue las instrucciones del correo para recuperar tu contraseña',
          duration: Duration(seconds: 20),
        )..show(context);
      } catch (e) {
        print("Forgot Password Error: $e");
        String exception = AuthenticationHelper().getExceptionText(e);
        Flushbar(
          title: "Error",
          message: exception,
          duration: Duration(seconds: 10),
        )..show(context);
      }
    }

    final recuperarPasswordButton = Padding(
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
          _recuperarPassword(email: _email.text, context: context);
        },
        child: Text('RECUPERAR CONTRASEÑA', style: TextStyle(color: Colors.white)),
      ),
    );

    final iniciarSesionLabel = TextButton(
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
                  SizedBox(height: 72.0),
                  email,
                  SizedBox(height: 36.0),
                  recuperarPasswordButton,
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