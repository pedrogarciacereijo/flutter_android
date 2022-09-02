import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/screens/autenticacion/recuperarPassword.dart';
import 'ui/screens/autenticacion/registrarse.dart';
import 'package:flutter_tfg/ui/screens/resultados.dart';

import 'ui/screens/home_page.dart';
import 'ui/screens/autenticacion/iniciarSesion.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Demo';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: IniciarSesionScreen(),
      initialRoute: '/iniciarSesion',
      routes: {
        '/homePage': (context) => HomePage(),
        '/iniciarSesion': (context) => IniciarSesionScreen(),
        '/registrarse': (context) => RegistrarseScreen(),
        '/resultados': (context) => ResultadosScreen(),
        '/recuperarPassword': (context) => RecuperarPassword(),
      },
    );
  }
}
