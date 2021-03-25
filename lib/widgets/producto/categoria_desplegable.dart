import 'package:almacen_frontend/models/categoria.dart';
import 'package:almacen_frontend/services/categoria_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CategoriaDesplegable extends StatefulWidget {
  @override
  _CategoriaDesplegableState createState() => _CategoriaDesplegableState();
}

class _CategoriaDesplegableState extends State<CategoriaDesplegable> {
  CategoriaService _categoriaServiceGet;

  List<Categoria> _listCategorias;
  @override
  void initState() {
    super.initState();
    this._categoriaServiceGet =
        Provider.of<CategoriaService>(context, listen: false);

    Future.delayed(Duration.zero).then((_) {
      this._categoriaServiceGet.getCategorias();
    });
  }
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     this._categoriaServiceGet = Provider.of<CategoriaService>(
  //       context,
  //     );
  //     this._categoriaServiceGet.getCategorias();
  //     this._listCategorias = this._categoriaServiceGet.listCategorias;
  //   }
  //   _isInit = false;

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.white24, offset: Offset(-2, 10))],
          borderRadius: BorderRadius.circular(50),
          color: Colors.white),
      child: Row(
        children: [
          Icon(
            Icons.category,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: _categoriasMenu()),
        ],
      ),
    );
  }

  _categoriasMenu() {
    String _value = '0';
    _listCategorias = Provider.of<CategoriaService>(context).listCategorias;

    if (_listCategorias.length > 0) {
      setState(() {
        _value = _listCategorias.elementAt(0).id.toString();
      });
    } else {
      setState(() {
        _value = '0';
      });
    }

    return DropdownButton(
      value: _value,
      isExpanded: true,
      iconEnabledColor: Colors.blue,
      style: TextStyle(color: Colors.blue, fontSize: 18),
      items: _categoriaItems(_listCategorias),
      onChanged: (String _val) {
        setState(() {
          _value = _val;
          print(_value);
        });
      },
    );
  }

  List<DropdownMenuItem<String>> _categoriaItems(List<Categoria> _categorias) {
    return _categorias.map((_categoria) {
      return DropdownMenuItem(
        child: Text(_categoria.nombre),
        value: _categoria.id.toString(),
      );
    }).toList();
  }
}
