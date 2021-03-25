import 'package:flutter/material.dart';

class ProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> numeros = [];
    numeros = [1, 2, 3, 4, 5];
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, 'agregarProducto'),
          )
        ],
      ),
      body: Center(
        child: _listaProducto(numeros),
      ),
    );
  }
}

ListView _listaProducto(List<int> numeros) {
  return ListView.builder(
    itemCount: numeros.length,
    itemBuilder: (_, int index) {
      return _datosProducto(numeros, index);
    },
  );
}

ListTile _datosProducto(List<int> numeros, int index) {
  return ListTile(
    title: Text(numeros[index].toString()),
  );
}
