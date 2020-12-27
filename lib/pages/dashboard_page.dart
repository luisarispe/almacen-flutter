import 'package:almacen_frontend/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(usuario.nombre),
            RaisedButton(
                child: Text('Cerrar Sesión'),
                onPressed: () {
                  AuthService.eliminarToken();
                  Navigator.pushReplacementNamed(context, 'login');
                }),
            RaisedButton(
                child: Text('categorias'),
                onPressed: () {
                  Navigator.pushNamed(context, 'categorias');
                }),
          ],
        )),
      ),
    );
  }
}
