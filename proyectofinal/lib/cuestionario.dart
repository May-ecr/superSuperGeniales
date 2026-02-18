import 'package:flutter/material.dart';
import 'models/modelo_gastos.dart';

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

//dentro de aqui van todas las cosas que se van a ver en pantalla
//botones cajas de texto y mas
final TextEditingController _tituloControlador = TextEditingController();
final TextEditingController _cantidadControlador = TextEditingController();
//variablespara guardar lo que pone el usuario

String _seleccionarCategoria = "DIVIS";

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
          //AQUIIII O EN DONDE???
            children: [//todos los elementos dentro de la columna se guardan en los children
              TextField(//es la caja donde el usuario escribira 
                controller: _tituloControlador,//conectar las variables con los textfield
                decoration: InputDecoration(
                  labelText: 'TITULO'
                ),
              ),
              SizedBox(height: 20), //sirve para separar un campo de otro

            const SizedBox(height: 20,),

            Row(
              children: [
                Expanded(child: 
                TextField(
                controller: _cantidadControlador,
                decoration: InputDecoration(
                labelText: 'Cantidad',
                ),
                keyboardType: TextInputType.number,//para teclado numerico
              ),
              ),
              const SizedBox(width: 20,),

              //h fila para elegir la fecha 
              Row(// es como una caja para organizar los elementos 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,//sirve para acomodar los elementos, tecnicamente dice manda todo lo que este aqui al final row es a la derecha
              children: [
              Text(
                _fechaSeleccionada == null
                ?"Fecha no elegida" : "${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}",
              ),
              
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _seleccionarFecha,
                ),
              ],
            ),
            ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              DropdownButton(//lista desplegable 
              value: _seleccionarCategoria, //usa la variable de arriba para que ya este una seleccionada
              items: ['COMIDA', 'VIAJE', 'DIVIS', 'TRABAJO'].map((categoria) => DropdownMenuItem(value: categoria,//opciones de la lista, el map lo convierte en un elemento del menu 
              child: Text(categoria)
              ))
              .toList(),//convierte todo en una lista
              onChanged: (nuevaCategoria){//guarda lo que selecciona el usuario
                setState(() {//sirve para actualizar la pantalla
                  _seleccionarCategoria = nuevaCategoria!;
                });
              } ,
              ),

              Row(children: [
                TextButton(onPressed: (){Navigator.pop(context);
                }, child: const Text("Cancelar"),
                ),
                const SizedBox(width: 10,),//sirve de separador
                //h
              ElevatedButton(//boton normal
                onPressed: () {
                  final titulo = _tituloControlador.text;
                  final cantidad = double.tryParse(_cantidadControlador.text) ?? 0.0;
                  //hle agreggamos la fehca
                  final fecha = _fechaSeleccionada ?? DateTime.now();
                                  //  h ahora tiene la fecha en el texto final
                // final textoFinal = "$titulo - \$$cantidad - $fechaTexto"; //ahi solo le agregue la de la fecha para que lo muestre 
                // Navigator.pop(context, textoFinal);
                  final nuevoGasto = Gasto(
                    titulo: titulo,
                    cantidad: cantidad,
                    categoria: _seleccionarCategoria,
                    fecha: fecha,

                  );
                  Navigator.pop(context, nuevoGasto);

                //cierra la pantalla y muestra el texto
              },
              child: Text("Guardar"),

              ),

              ],)
              ],
            ),

              
            ],
          )
      ),
    
  );
  }
}