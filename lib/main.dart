import 'package:almacen_frontend/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:almacen_frontend/routes/routes.dart';
import 'package:almacen_frontend/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CategoriaService())
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
