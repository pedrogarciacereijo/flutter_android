import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tfg/models/ejercicio.dart';

class Usuario {

  String nombre;
  String email;
  String apellidos;

  Usuario(this.nombre,
      {this.email, this.apellidos});

  factory Usuario.fromJson(Map<String, dynamic> json) => _usuarioFromJson(json);

  Map<String, dynamic> toJson() => _usuarioToJson(this);

  @override
  String toString() => 'Usuario<$nombre>';
}

  Usuario _usuarioFromJson(Map<String, dynamic> json) {
    return Usuario(json['nombre'] as String,
        email: json['email'] as String,
        apellidos: json['referenceId'] as String,);
  }

  Map<String, dynamic> _usuarioToJson(Usuario instance) => <String, dynamic>{
    'nombre': instance.nombre,
    'email': instance.email,
    'apellidos': instance.apellidos,
  };

