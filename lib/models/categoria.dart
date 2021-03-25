// To parse this JSON data, do
//
//     final categoria = categoriaFromJson(jsonString);

import 'dart:convert';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
  Categoria({
    this.estado,
    this.nombre,
    this.idUsuario,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  int estado;
  String nombre;
  int idUsuario;
  DateTime createdAt;
  DateTime updatedAt;
  int id;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        estado: json["estado"],
        nombre: json["nombre"],
        idUsuario: json["id_usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "nombre": nombre,
        "id_usuario": idUsuario,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}
