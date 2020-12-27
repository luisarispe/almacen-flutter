import 'package:flutter/material.dart';

class BotonPersonalizado extends StatelessWidget {
  final String titulo;
  final String route;
  final Function onPressed;
  const BotonPersonalizado(
      {Key key,
      @required this.titulo,
      @required this.route,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: StadiumBorder(),
      color: Colors.blue,
      elevation: 3,
      hoverElevation: 10,
      onPressed: onPressed,

      // Navigator.pushReplacementNamed(context, route);

      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
