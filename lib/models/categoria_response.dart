// To parse this JSON data, do
//
//     final categoriaResponse = categoriaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:almacen_frontend/models/categoria.dart';

CategoriaResponse categoriaResponseFromJson(String str) =>
    CategoriaResponse.fromJson(json.decode(str));

String categoriaResponseToJson(CategoriaResponse data) =>
    json.encode(data.toJson());

class CategoriaResponse {
  CategoriaResponse({
    this.ok,
    this.mensaje,
    this.categorias,
  });

  bool ok;
  String mensaje;
  List<Categoria> categorias;

  factory CategoriaResponse.fromJson(Map<String, dynamic> json) =>
      CategoriaResponse(
        ok: json["ok"],
        mensaje: json["mensaje"],
        categorias: List<Categoria>.from(
            json["categorias"].map((x) => Categoria.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensaje": mensaje,
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
      };
}
