import 'dart:ui';

import 'package:flutter/material.dart';
import 'models/modelo_gastos.dart';

class Cuestionario extends StatefulWidget{
  final Gasto? gastoAEditar; // Para saber si estamos editando
  final int? index; // Opcional, por si necesitas el índice
  
  const Cuestionario({super.key, this.gastoAEditar, this.index});

  @override
  State<Cuestionario> createState() {
    return _CuestionarioState();
  }
}

class _CuestionarioState extends State<Cuestionario>{
  final TextEditingController _tituloControlador = TextEditingController();
  final TextEditingController _cantidadControlador = TextEditingController();

  String _seleccionarCategoria = "Gym";
  DateTime? _fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    // Si estamos editando, llenamos los campos con los datos existentes
    if (widget.gastoAEditar != null) {
      _tituloControlador.text = widget.gastoAEditar!.titulo;
      _cantidadControlador.text = widget.gastoAEditar!.cantidad.toString();
      _seleccionarCategoria = widget.gastoAEditar!.categoria;
      _fechaSeleccionada = widget.gastoAEditar!.fecha;
    }
  }

  void _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
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
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text(widget.gastoAEditar == null ? "Nuevo gasto" : "Editar gasto"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloControlador,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'TÍTULO',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cantidadControlador,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'CANTIDAD',
                      border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                
                Row(
                  children: [
                    Text(
                      _fechaSeleccionada == null
                          ? "Fecha no elegida" 
                          : "${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _seleccionarFecha,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: _seleccionarCategoria,
                  items: ['COMIDA', 'VIAJE', 'Gym', 'TRABAJO'].map((categoria) => 
                    DropdownMenuItem(
                      value: categoria,
                      child: Text(categoria)
                    )
                  ).toList(),
                  onChanged: (nuevaCategoria){
                    setState(() {
                      _seleccionarCategoria = nuevaCategoria!;
                    });
                  },
                  dropdownColor: Colors.lightBlue.shade50,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),

                Row(
                  children: [
                    TextButton(
                      onPressed: (){Navigator.pop(context);}, 
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 1),
                      ),
                      child: const Text("Cancelar"),
                    ),
                    const SizedBox(width: 15),
                    
                    ElevatedButton(
                      onPressed: () {
                        final titulo = _tituloControlador.text;
                        final cantidad = double.tryParse(_cantidadControlador.text) ?? 0.0;
                        final fecha = _fechaSeleccionada ?? DateTime.now();
                        
                        final nuevoGasto = Gasto(
                          titulo: titulo,
                          cantidad: cantidad,
                          categoria: _seleccionarCategoria,
                          fecha: fecha,
                        );
                        
                        Navigator.pop(context, nuevoGasto);
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 1), 
                      ),
                      child: Text(widget.gastoAEditar == null ? "Guardar" : "Actualizar"),
                    ),
                  ],
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}