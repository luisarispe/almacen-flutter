import 'package:almacen_frontend/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

alertaAgregar(BuildContext context) {
  final _ctrlACategoria = TextEditingController();
  bool _habilitar = false;
  _ctrlACategoria.text = '';
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Agregar'),
              content: TextField(
                onChanged: (v) {
                  setState(() {
                    if (v.isNotEmpty) {
                      _habilitar = true;
                    } else {
                      _habilitar = false;
                    }
                  });
                },
                controller: _ctrlACategoria,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                FlatButton(
                  onPressed: (_habilitar)
                      ? () => _agregarCategoria(
                          _ctrlACategoria.text.trim(), context)
                      : null,
                  child: Text("Agregar"),
                )
              ],
            );
          },
        );
      });
}

void _agregarCategoria(categoria, BuildContext context) async {
  final _categoriaServiceGet =
      Provider.of<CategoriaService>(context, listen: false);
  final resp = await _categoriaServiceGet.agregarCategoria(categoria);
  if (!resp['ok']) {
    SweetAlert.show(context, subtitle: resp['mensaje']);
  } else {
    Navigator.pop(context);
  }
}
