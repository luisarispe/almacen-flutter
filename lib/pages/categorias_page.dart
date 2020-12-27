import 'dart:ui';

import 'package:almacen_frontend/models/categoria.dart';
import 'package:almacen_frontend/services/categoria_service.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class CategoriasPage extends StatefulWidget {
  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  CategoriaService _categoriaService;
  final _ctrlCategoria = TextEditingController();
  @override
  void initState() {
    super.initState();
    this._categoriaService =
        Provider.of<CategoriaService>(context, listen: false);
    // this._categoriaService.listCategorias = [];
    this._categoriaService.getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    final _listaCategorias =
        Provider.of<CategoriaService>(context).listCategorias;
    final mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Categorias'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _listaCategorias.length == 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.4,
                        ),
                        Center(child: CircularProgressIndicator())
                      ],
                    )
                  : _listaCategoria(_listaCategorias)
            ],
          ),
        ));
  }

  Widget _listaCategoria(List<Categoria> categorias) {
    return ListView.builder(
        // separatorBuilder: (_, i) => Divider(),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (_, i) => _categoriaTitle(categorias[i]),
        itemCount: categorias.length);
  }

  Widget _categoriaTitle(Categoria categoria) {
    String fechaFormateada =
        DateFormat('dd-MM-yyyy – HH:mm:ss').format(categoria.fechaCreado);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          color: Colors.white,
          child: ListTile(
              trailing: _mostrarEstado(categoria.estado),
              subtitle: Text('fecha Creado :$fechaFormateada'),
              title: Text(categoria.nombre))),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Editar',
            color: Colors.black45,
            icon: Icons.edit,
            onTap: () => _alertaEditar(categoria, context)),
        IconSlideAction(
            caption: (categoria.estado == 0) ? 'Activar' : 'Desactivar',
            color: (categoria.estado == 0) ? Colors.blue : Colors.red,
            icon: (categoria.estado == 0)
                ? Icons.check_box_outlined
                : Icons.delete,
            onTap: () => _cambiarEstado(categoria.id))
      ],
    );
  }

  void _cambiarEstado(id) async {
    final resp = await this._categoriaService.cambiarEstado(id);
    if (!resp) {
      SweetAlert.show(context, subtitle: "Error al cambiar el estado.");
    }
  }

  Widget _mostrarEstado(estado) {
    String textoEstado = '';
    if (estado == 1) {
      textoEstado = 'Activo';
    } else {
      textoEstado = 'Inactivo';
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (estado == 1) ? Colors.blue : Colors.red),
      child: Text(
        textoEstado,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _alertaEditar(Categoria categoria, BuildContext context) {
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
                        ? () =>
                            _editarCategoria(categoria.id, _ctrlCategoria.text)
                        : null,
                    child: Text("Actualizar"),
                  )
                ],
              );
            },
          );
        });
  }

  void _editarCategoria(id, nombre) {
    print(nombre);
  }
}
