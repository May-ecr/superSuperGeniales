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
final TextEditingController _tituloControlador = TextEditingController();
final TextEditingController _cantidadControlador = TextEditingController();
//variablespara guardar lo que pone el usuario

// h  variable para guardar la fecha
DateTime? _fechaSeleccionada;

// h esto es para poder abrir el calendario 
void _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(//contenedor principal
//da el lugar para poner el contenido es como un marco 
        body: Padding(//es espacio alrededor 
          padding: EdgeInsets.all(16),//agrega 16 pixeles para todo los datos 
          child: Column(//sirve para agregar cosas una debajo de otra de forma vertical
            children: [//todos los elementos dentro de la columna se guardan en los children
              TextField(//es la caja donde el usuario escribira 
                controller: _tituloControlador,//conectar las variables con los textfield
                decoration: InputDecoration(
                  labelText: 'TITULO'
                ),
              ),
              SizedBox(height: 20), //sirve para separar un campo de otro
              TextField(
                controller: _cantidadControlador,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                ),
                keyboardType: TextInputType.number,//para teclado numerico
              ),
              //h fila para elegir la fecha 
              Row(// es como una caja para organizar los elementos 
              children: [
                Expanded(
                  child: Text(
                    _fechaSeleccionada == null
                        ? "Fecha no elegida"
                        : "Fecha: ${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}",
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _seleccionarFecha,
                ),
              ],
            ),
              //h
              const SizedBox(height: 30,),

              ElevatedButton(//boton normal
                onPressed: () {
                  final titulo = _tituloControlador.text;
                  final cantidad = _cantidadControlador.text;
                  //hle agreggamos la fehca
                  final fechaTexto = _fechaSeleccionada == null
                    ? "Sin fecha" //indicara que no tiene fecha si no la selecionamos 
                    //,ostrara la fecha
                    : "${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}";

                //  h ahora tiene la fecha en el texto final
                final textoFinal = "$titulo - \$${cantidad} - $fechaTexto"; //ahi solo le agregue la de la fecha para que lo muestre 
                Navigator.pop(context, textoFinal);

                //cierra la pantalla y muestra el texto
              },
              child: Text("Guardar"),
              ),
            ],
          )
      ),
    
  );
  }
}