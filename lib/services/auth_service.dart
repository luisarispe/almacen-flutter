import 'package:almacen_frontend/models/login_response.dart';
import 'package:almacen_frontend/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:almacen_frontend/global/env.dart';

class AuthService with ChangeNotifier {
  bool _autenticando = false;
  bool get autenticando => this._autenticando;
  Usuario usuario;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  //STORAGE
  final _storage = FlutterSecureStorage();
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> eliminarToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String correo, String contrasena) async {
    this.autenticando = true;
    final data = {'correo': correo, "contrasena": contrasena};

    final url = '${Env.apiUrl}usuario/login';

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future registro(String nombre, String correo, String contrasena) async {
    final _data = {
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena
    };
    final _url = '${Env.apiUrl}usuario/agregar';
    final resp = await http.post(_url,
        body: json.encode(_data),
        headers: {'Content-Type': 'application/json'});

    final respuesta = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      return respuesta;
    } else {
      return respuesta;
    }
  }

  Future<bool> verificarLogin() async {
    final _token = await _storage.read(key: 'token');
    final url = '${Env.apiUrl}usuario/renewToken';
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': _token});
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      return true;
    } else {
      await logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
