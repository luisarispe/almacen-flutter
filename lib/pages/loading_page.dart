import 'package:almacen_frontend/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: verificarLogin(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(), Text('Cargando...')],
            );
          },
        ),
      ),
    );
  }

  Future verificarLogin(BuildContext context) async {
    final authService = Provider.of<AuthService>(context);
    final bool respuesa = await authService.verificarLogin();
    if (respuesa) {
      Navigator.pushReplacementNamed(context, 'dashboard');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
