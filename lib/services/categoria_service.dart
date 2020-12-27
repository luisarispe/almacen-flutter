import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:almacen_frontend/global/env.dart';
import 'package:almacen_frontend/models/categoria.dart';
import 'package:almacen_frontend/models/categoria_response.dart';
import 'package:almacen_frontend/services/auth_service.dart';
import 'package:http/http.dart' as http;

class CategoriaService with ChangeNotifier {
  List<Categoria> _categorias = [];

  List<Categoria> get listCategorias => _categorias;
  set listCategorias(List<Categoria> val) {
    _categorias = val;
    notifyListeners();
  }

  getCategorias() async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get('${Env.apiUrl}/categoriaproducto/listar',
          headers: {'Content-Type': 'application/json', 'x-token': token});
      if (resp.statusCode == 200) {
        final categoriaResponse = categoriaResponseFromJson(resp.body);
        listCategorias = categoriaResponse.categorias;
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
}
