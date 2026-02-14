import 'package:flutter/material.dart';
//import 'package:proyectofinal/cuestionario.dart';
import 'package:proyectofinal/pantalla_principal.dart';

void main (){
  runApp(
    const MyApp()
  );
}
 //esto no se pq se tuvo que crear pero si no lo ponia me salia una pantalla roja jajaja
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: pantallaPrincipal(),
    );
  }
}
