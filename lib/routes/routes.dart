import 'package:almacen_frontend/pages/categorias_page.dart';
import 'package:almacen_frontend/pages/dashboard_page.dart';
import 'package:almacen_frontend/pages/loading_page.dart';
import 'package:almacen_frontend/pages/login_page.dart';
import 'package:almacen_frontend/pages/registro_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "login": (_) => LoginPage(),
  'registro': (_) => RegistroPage(),
  'dashboard': (_) => DashboardPage(),
  'loading': (_) => LoadingPage(),
  'categorias': (_) => CategoriasPage()
};
