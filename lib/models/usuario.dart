// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.estado,
    this.nombre,
    this.correo,
    this.fechaCreado,
    this.id,
  });

  int estado;
  String nombre;
  String correo;
  DateTime fechaCreado;
  String id;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        estado: json["estado"],
        nombre: json["nombre"],
        correo: json["correo"],
        fechaCreado: DateTime.parse(json["fecha_creado"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "nombre": nombre,
        "correo": correo,
        "fecha_creado": fechaCreado.toIso8601String(),
        "id": id,
      };
}
