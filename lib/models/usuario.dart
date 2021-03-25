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
    this.createdAt,
    this.id,
  });

  int estado;
  String nombre;
  String correo;
  DateTime createdAt;
  int id;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        estado: json["estado"],
        nombre: json["nombre"],
        correo: json["correo"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "nombre": nombre,
        "correo": correo,
        "fecha_creado": createdAt.toIso8601String(),
        "id": id,
      };
}
