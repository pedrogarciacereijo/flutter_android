// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Import the Usuario model
import '../models/usuario.dart';
import '../models/ejercicio.dart';

class FirestoreHelper{
  // Create a CollectionReference called usuarios that references the firestore collection
  final CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

  // Create a CollectionReference called ejercicios that references the firestore collection
  final CollectionReference ejercicios = FirebaseFirestore.instance.collection('ejercicios');

  Stream<QuerySnapshot> getStream() {
    return usuarios.snapshots();
  }

  Future<bool> comprobarUsuarioAutorizado(String email) async {
    // Comprueba si existe el usuario en la base de datos antes de permitirle iniciar sesión
    bool aux = false;
    await usuarios.doc(email).get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            print('El usuario existe en la base de datos');
            aux = true;
          }
          else{
            print('El usuario no existe en la base de datos');
          }
        });
    return aux;
  }

  Future<void> addEjercicio(Ejercicio ejercicio) {
    // Call the user's CollectionReference to add a new user
    return ejercicios.add(ejercicio.toJson())
        .then((value) => print("Ejercicio añadido"))
        .catchError((error) => print("Error al añadir ejercicio: $error"));
  }

  void updateUsuario(Usuario usuario) async {
    await usuarios.doc(usuario.email).update(usuario.toJson());
  }

  void deleteUsuario(Usuario usuario) async {
    await usuarios.doc(usuario.email).delete();
  }

  Future<Usuario> getUsuario() async {
    Usuario usuario;
    String email = usuario.email;
    usuarios.doc(email).get().then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {

        Usuario(docSnapshot.get(FieldPath(['nombre'])),
                apellidos: docSnapshot.get(FieldPath(['apellidos'])),
                email: docSnapshot.get(FieldPath(['email']))

        );
      } else {
        print('User does not exist on the database');
      };
    });
    return usuario;
  }



}
