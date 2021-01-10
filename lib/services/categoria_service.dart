import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:almacen_frontend/global/env.dart';
import 'package:almacen_frontend/models/categoria.dart';
import 'package:almacen_frontend/models/categoria_response.dart';
import 'package:almacen_frontend/services/auth_service.dart';
import 'package:http/http.dart' as http;

class CategoriaService with ChangeNotifier {
  List<Categoria> _categorias = [];
  bool _cargando = false;

  List<Categoria> get listCategorias => _categorias;
  set listCategorias(List<Categoria> val) {
    _categorias = val;
    notifyListeners();
  }

  bool get cargandoCategorias => _cargando;
  set cargandoCategorias(val) {
    _cargando = val;
    notifyListeners();
  }

  Future getCategorias() async {
    cargandoCategorias = true;
    try {
      final token = await AuthService.getToken();
      final resp = await http.get('${Env.apiUrl}/categoriaproducto/listar',
          headers: {'Content-Type': 'application/json', 'x-token': token});

      if (resp.statusCode == 200) {
        final categoriaResponse = categoriaResponseFromJson(resp.body);
        listCategorias = categoriaResponse.categorias;
        cargandoCategorias = false;
      } else {
        listCategorias = [];
      }
    } catch (e) {
      listCategorias = [];
    }
  }

  Future<bool> cambiarEstado(String idCategoria) async {
    try {
      final token = await AuthService.getToken();

      final resp = await http.put(
          '${Env.apiUrl}categoriaproducto/cambiarEstado?id=$idCategoria',
          headers: {'Content-Type': 'application/json', 'x-token': token});
      final respuesta = jsonDecode(resp.body);
      final bool ok = respuesta['ok'];
      this.getCategorias();
      return ok;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> actualizarCategoria(
      String idCategoria, String categoria) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.put(
          '${Env.apiUrl}categoriaproducto/actualizar?id=$idCategoria',
          headers: {'Content-Type': 'application/json', 'x-token': token},
          body: jsonEncode({'nombre': categoria}));

      final respuesta = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        this.getCategorias();
      }
      return respuesta;
    } catch (e) {
      Map respuesta = Map<String, dynamic>();
      respuesta = {
        "ok": false,
        "mensaje": "Error, Hable con el administrador."
      };
      return respuesta;
    }
  }

  Future<dynamic> agregarCategoria(String categoria) async {
    final token = await AuthService.getToken();
    try {
      final resp = await http.post('${Env.apiUrl}categoriaproducto/agregar',
          headers: {'Content-Type': 'application/json', 'x-token': token},
          body: jsonEncode({"nombre": categoria}));

      if (resp.statusCode == 200) {
        this.getCategorias();
      }
      final respuesta = jsonDecode(resp.body);
      return respuesta;
    } catch (e) {
      Map respuesta = Map<String, dynamic>();
      respuesta = {
        "ok": false,
        "mensaje": "Error, Hable con el administrador."
      };
      return respuesta;
    }
  }
}
