import 'package:almacen_frontend/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Center(
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
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(offset, BuildContext context) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
            child: GestureDetector(
                onTap: () {
                  AuthService.eliminarToken();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: Text('Cerrar Sesión'))),
      ],
      elevation: 1.0,
    );
  }

  _header(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _showPopupMenu(details.globalPosition, context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Color(0xffF2714E),
                ),
                Column(
                  children: [Icon(Icons.arrow_drop_down)],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
