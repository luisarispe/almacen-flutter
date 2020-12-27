import 'package:flutter/material.dart';

class InputPersonalizado extends StatelessWidget {
  final TextInputType textInput;
  final IconData iconInput;
  final String labelinput;
  final TextEditingController ctrlInput;
  final bool contrasenaInput;

  const InputPersonalizado(
      {Key key,
      @required this.textInput,
      @required this.iconInput,
      @required this.labelinput,
      @required this.ctrlInput,
      this.contrasenaInput = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.white24, offset: Offset(-2, 10))
            ],
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(50)),
        child: TextField(
          obscureText: contrasenaInput,
          controller: ctrlInput,
          autocorrect: false,
          keyboardType: textInput,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.blue[300]),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(
                iconInput,
                color: Colors.blue[300],
              ),
              labelText: labelinput),
        ));
  }
}
