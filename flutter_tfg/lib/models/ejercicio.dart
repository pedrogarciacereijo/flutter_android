import 'package:cloud_firestore/cloud_firestore.dart';

class Ejercicio {
  final String idUsuario;
  final DateTime dateInicio;
  final DateTime dateFin;
  final String tipoEjercicio;
  final String dificultad;
  final int errores;
  final int aciertos;
  final int letrasCorrectas;

  Ejercicio(this.idUsuario, {this.dateInicio, this.dateFin, this.tipoEjercicio, this.dificultad, this.errores, this.aciertos, this.letrasCorrectas});

  factory Ejercicio.fromJson(Map<String, Ejercicio> json) =>
      _ejercicioFromJson(json);

  Map<String, dynamic> toJson() => _ejercicioToJson(this);

  @override
  String toString() => 'Ejercicio de usuario:<$idUsuario>';
}

Ejercicio _ejercicioFromJson(Map<String, dynamic> json) {
  return Ejercicio(
    json['idUsuario'] as String,
    dateInicio: (json['dateInicio'] as Timestamp).toDate(),
    dateFin: (json['dateFin'] as Timestamp).toDate(),
    tipoEjercicio: json['tipoEjercicio'] as String,
    dificultad: json['dificultad'] as String,
    errores: json['errores'] as int,
    aciertos: json['aciertos'] as int,
    letrasCorrectas: json['letrasCorrectas'] as int,
  );
}

Map<String, dynamic> _ejercicioToJson(Ejercicio instance) =>
    <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'dateInicio': instance.dateInicio,
      'dateFin': instance.dateFin,
      'tipoEjercicio': instance.tipoEjercicio,
      'dificultad': instance.dificultad,
      'errores': instance.errores,
      'aciertos': instance.aciertos,
      'letrasCorrectas': instance.letrasCorrectas
    };