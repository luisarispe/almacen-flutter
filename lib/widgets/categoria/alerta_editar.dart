import 'package:almacen_frontend/models/categoria.dart';
import 'package:almacen_frontend/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

alertaEditar(BuildContext context, Categoria categoria) {
  final _ctrlCategoria = TextEditingController();
  _ctrlCategoria.text = categoria.nombre;
  bool _habilitar = true;
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Editar'),
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
                controller: _ctrlCategoria,
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
                      ? () => _editarCategoria(
                          categoria.id, _ctrlCategoria.text.trim(), context)
                      : null,
                  child: Text("Actualizar"),
                )
              ],
            );
          },
        );
      });
}

void _editarCategoria(id, nombre, BuildContext context) async {
  final _categoriaServiceGet =
      Provider.of<CategoriaService>(context, listen: false);
  final resp = await _categoriaServiceGet.actualizarCategoria(id, nombre);

  if (!resp['ok']) {
    SweetAlert.show(context, subtitle: resp['mensaje']);
  } else {
    Navigator.pop(context);
  }
}
