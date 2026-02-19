import 'package:flutter/material.dart';
import 'package:proyectofinal/models/modelo_gastos.dart'; 
import 'cuestionario.dart';
import 'package:proyectofinal/pantalla_grafica.dart';

class pantallaPrincipal extends StatefulWidget{
  const pantallaPrincipal({super.key});

  @override
  State<pantallaPrincipal> createState(){
    return _pantallaPrincipalState();
  }
}

class _pantallaPrincipalState extends State<pantallaPrincipal>{
  final List<Gasto> _gastos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text("Mis gastos",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black26,
              )
            ]
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: _mostrarGrafica,
          ),
        ],
      ),
      body: _gastos.isEmpty ? const Center(
        child: Text("No hay gastos."),
      )
      : ListView.builder(
          itemCount: _gastos.length,
          itemBuilder: (context, index){
            final gasto = _gastos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              elevation: 2,
              child: ListTile(
                leading: Text(
                  _getEmojiForCategory(gasto.categoria),
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(gasto.titulo),
                subtitle: Text(
                  "${gasto.categoria}, ${gasto.fecha.day}/${gasto.fecha.month}/${gasto.fecha.year}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "\$${gasto.cantidad.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    // Botón de editar
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                      onPressed: () => _editarGasto(gasto, index),
                    ),
                    // Botón de eliminar
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: () => _eliminarGasto(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoGasto = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Cuestionario()),
          );

          if (nuevoGasto != null && nuevoGasto is Gasto){
            _agregarGasto(nuevoGasto);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }  

  void _agregarGasto(Gasto nuevoGasto) {
    setState(() {
      _gastos.add(nuevoGasto);
      _ordenarGastosPorFecha();
    });
  }

  void _editarGasto(Gasto gastoExistente, int index) async {
    final gastoEditado = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Cuestionario(
          gastoAEditar: gastoExistente,
          index: index,
        ),
      ),
    );

    if (gastoEditado != null && gastoEditado is Gasto) {
      setState(() {
        _gastos[index] = gastoEditado;
        _ordenarGastosPorFecha();
      });
    }
  }

  void _eliminarGasto(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar gasto"),
          content: const Text("¿Estás seguro de que quieres eliminar este gasto?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _gastos.removeAt(index);
                });
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  void _ordenarGastosPorFecha() {
    _gastos.sort((a, b) => b.fecha.compareTo(a.fecha)); // Más recientes primero
    // Si quieres los más antiguos primero, usa a.fecha.compareTo(b.fecha)
  }

  void _mostrarGrafica(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PantallaGrafica(gastos: _gastos),
      ),
    );
  }
}

String _getEmojiForCategory(String category) {
  switch (category) {
    case 'COMIDA':
      return '🍔';
    case 'VIAJE':
      return '✈️';
    case 'Gym':
      return '🏋️';
    case 'TRABAJO':
      return '🧳';
    default:
      return '❓';
  }
}