import 'package:flutter/material.dart';

class LabelLogin extends StatelessWidget {
  final String labelTitle;
  final String labelSubTitle;
  final String ruta;
  const LabelLogin(
      {Key key,
      @required this.labelTitle,
      @required this.labelSubTitle,
      @required this.ruta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          labelTitle,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(
            labelSubTitle,
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Terminos y condiciones legales',
          style: TextStyle(fontWeight: FontWeight.w100),
        )
      ],
    );
  }
}
