import 'package:flutter/material.dart';

//crea una pantalla que va a cambiar cuando se presione un boton, es crear un lienzo en blanco 
class Cuestionario extends StatefulWidget{
  const Cuestionario({super.key});

//se crea para tener datos que pueden cambiar
  @override
  State<Cuestionario> createState() {
    return _CuestionarioState();
  }
}

//se crea para guardar todos los datos del cuestionario
class _CuestionarioState extends State<Cuestionario>{

// @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text("HOLAAAAAAAA SOLO QUIERO VER SI ESTO FUNCIONA "),
//         ),
//       ),
//     );
//   }

//dentro de aqui van todas las cosas que se van a ver en pantalla
//botones cajas de texto y mas
@override
  Widget build(BuildContext context) {
    return MaterialApp(//contenedor principal
      home: Scaffold(//da el lugar para poner el contenido es como un marco 
        body: Padding(//es espacio alrededor 
          padding: EdgeInsets.all(16),//agrega 16 pixeles para todo los datos 
          child: Column(//sirve para agregar cosas una debajo de otra de forma vertical
            children: [//todos los elementos dentro de la columna se guardan en los children
              TextField(//es la caja donde el usuario escribira 
                decoration: InputDecoration(
                  labelText: 'TITULO'
                ),
              ),
              SizedBox(height: 20), //sirve para separar un campo de otro
              TextField(
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                ),
              )
            ],
          )
      ),
    ),
  );
  }
}