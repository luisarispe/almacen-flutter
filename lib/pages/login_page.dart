import 'dart:ui';

import 'package:almacen_frontend/services/auth_service.dart';
import 'package:almacen_frontend/widgets/boton_personalizado.dart';
import 'package:almacen_frontend/widgets/input_personalizado.dart';
import 'package:almacen_frontend/widgets/label_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.business_outlined,
                      color: Colors.blue[300],
                      size: 200,
                    ),
                    Text(
                      'TradeFactory',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300]),
                    ),
                    Formulario(),
                    LabelLogin(
                      labelTitle: '¿No tienes una cuenta?',
                      labelSubTitle: 'Crea una ahora',
                      ruta: 'registro',
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final ctrlCorreo = TextEditingController();

  final ctrlContrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 50),
      child: Column(
        children: [
          InputPersonalizado(
            textInput: TextInputType.emailAddress,
            iconInput: Icons.email_outlined,
            labelinput: 'correo',
            ctrlInput: ctrlCorreo,
          ),
          SizedBox(
            height: 15,
          ),
          InputPersonalizado(
            textInput: TextInputType.text,
            iconInput: Icons.lock_outline,
            labelinput: 'contraseña',
            ctrlInput: ctrlContrasena,
            contrasenaInput: true,
          ),
          SizedBox(
            height: 15,
          ),
          BotonPersonalizado(
            onPressed: (authService.autenticando)
                ? null
                : () async {
                    final estadook = await authService.login(
                        ctrlCorreo.text.toString(),
                        ctrlContrasena.text.toString());
                    if (estadook) {
                      Navigator.pushReplacementNamed(context, 'dashboard');
                    } else {
                      SweetAlert.show(context,
                          subtitle: "Usuario y/o Contraseña incorrecta");
                    }
                  },
            route: 'dashboard',
            titulo: 'Ingresa',
          ),
        ],
      ),
    );
  }
}
