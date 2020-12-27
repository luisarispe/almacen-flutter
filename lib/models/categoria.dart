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
    this.usuario,
    this.fechaCreado,
    this.fechaActualizado,
    this.id,
  });

  int estado;
  String nombre;
  String usuario;
  DateTime fechaCreado;
  DateTime fechaActualizado;
  String id;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        estado: json["estado"],
        nombre: json["nombre"],
        usuario: json["usuario"],
        fechaCreado: DateTime.parse(json["fecha_creado"]),
        fechaActualizado: DateTime.parse(json["fecha_actualizado"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "nombre": nombre,
        "usuario": usuario,
        "fecha_creado": fechaCreado.toIso8601String(),
        "fecha_actualizado": fechaActualizado.toIso8601String(),
        "id": id,
      };
}
