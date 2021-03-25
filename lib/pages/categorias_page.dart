import 'dart:ui';

import 'package:almacen_frontend/models/categoria.dart';
import 'package:almacen_frontend/services/categoria_service.dart';

import 'package:almacen_frontend/widgets/categoria/alerta_agregar.dart';
import 'package:almacen_frontend/widgets/categoria/alerta_editar.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class CategoriasPage extends StatefulWidget {
  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  CategoriaService _categoriaServiceGet;
  @override
  void initState() {
    super.initState();
    this._categoriaServiceGet =
        Provider.of<CategoriaService>(context, listen: false);
    // this._categoriaServiceGet.listCategorias = [];
    Future.delayed(Duration.zero).then((_) {
      this._categoriaServiceGet.getCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _categoriaService = Provider.of<CategoriaService>(context);
    final mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Categorias'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => alertaAgregar(context),
            )
          ],
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Column(
              children: [
                (_categoriaService.listCategorias.length == 0)
                    ? Container(
                        height: size.height * 0.95,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('No existen Categorias.')),
                      )
                    : _listaCategoria(_categoriaService.listCategorias)
              ],
            ),
          ),
          inAsyncCall: _categoriaService.cargandoCategorias,
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
        DateFormat('dd-MM-yyyy – HH:mm:ss').format(categoria.createdAt);

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
        if (categoria.estado == 1)
          IconSlideAction(
              caption: 'Editar',
              color: Colors.black45,
              icon: Icons.edit,
              onTap: () => alertaEditar(context, categoria)),
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

  void _cambiarEstado(id) async {
    final resp = await this._categoriaServiceGet.cambiarEstado(id);
    if (!resp) {
      SweetAlert.show(context, subtitle: "Error al cambiar el estado.");
    }
  }
}
