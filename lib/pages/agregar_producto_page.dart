import 'package:almacen_frontend/services/categoria_service.dart';
import 'package:almacen_frontend/widgets/input_personalizado.dart';
import 'package:almacen_frontend/widgets/producto/categoria_desplegable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AgregarProducto extends StatelessWidget {
  const AgregarProducto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _categoriaService = Provider.of<CategoriaService>(context);
    TextEditingController _ctrnombre = new TextEditingController();
    TextEditingController _ctrlcantidad = new TextEditingController();
    TextEditingController _ctrlPrecio = new TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Producto"),
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  InputPersonalizado(
                    labelinput: "Producto",
                    iconInput: Icons.panorama_fisheye_rounded,
                    textInput: TextInputType.text,
                    ctrlInput: _ctrnombre,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputPersonalizado(
                    labelinput: "Cantidad",
                    iconInput: Icons.format_list_numbered,
                    textInput: TextInputType.number,
                    ctrlInput: _ctrlcantidad,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputPersonalizado(
                    labelinput: "Precio",
                    iconInput: Icons.monetization_on_outlined,
                    textInput: TextInputType.number,
                    ctrlInput: _ctrlPrecio,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CategoriaDesplegable()
                ],
              ),
            ),
          ),
          inAsyncCall: _categoriaService.cargandoCategorias,
        ));
  }
}
