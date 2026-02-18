import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'models/modelo_gastos.dart';



class PantallaGrafica extends StatelessWidget {
  final List<Gasto> gastos;
  const PantallaGrafica({super.key, required this.gastos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gastos por categoría"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Distribución de gastos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(child: _crearGraficaPastel(),
            ),
            const SizedBox(height: 20),
            _crearLeyenda(),
          ],
          ),
        ),
    );
    
  }

  Widget _crearGraficaPastel(){
    Map<String, double> gastosPorCategoria = {};//pun map para filtrar los gastos

    for (var gasto in gastos){
      if(gastosPorCategoria.containsKey(gasto.categoria)){
        gastosPorCategoria[gasto.categoria] = 
          gastosPorCategoria[gasto.categoria]! + gasto.cantidad;
      }else{
        gastosPorCategoria[gasto.categoria] = gasto.cantidad;
      }
    }
    //aqui es lo que se verá si no hay gastos
    if(gastosPorCategoria.isEmpty){
      return const Center(child: Text("No hay gastos disponibles"),
      );
    }

    //aqui creamoos las secciones de la grafiquita linda 
    List<PieChartSectionData> sections=[];
    int index = 0;

    gastosPorCategoria.forEach((categoria, total){
      sections.add(
        PieChartSectionData(
          value: total,
          title: '\$${total.toStringAsFixed(0)}',
          color: _getColorForCategory(categoria, index),
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      index++;
    });

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 40,
        sectionsSpace: 2,
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _crearLeyenda() {
    //agrupar para poner la leyenda con otro map
    Map<String, double> gastosPorCategoria = {};
    double totalGeneral = 0;

    for (var gasto in gastos){
      totalGeneral += gasto.cantidad;
      if(gastosPorCategoria.containsKey(gasto.categoria)){
        gastosPorCategoria[gasto.categoria] =
          gastosPorCategoria[gasto.categoria]! + gasto.cantidad; 
      }else{
        gastosPorCategoria[gasto.categoria] = gasto.cantidad;
      }
    }

    return Column(
      children: gastosPorCategoria.entries.map((entry){
        int index = gastosPorCategoria.keys.toList().indexOf(entry.key);
        double porcentaje = (entry.value / totalGeneral) * 100;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: _getColorForCategory(entry.key, index),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${entry.key}: \$${entry.value.toStringAsFixed(2)} "
                  "(${porcentaje.toStringAsFixed(1)}%)",
                  style: const TextStyle(fontSize: 16),
                ),
                ),
            ],
            ),
          );
      }).toList(),
    );
  }

  Color _getColorForCategory(String category, int index) {
    //colores para cada categoria 
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];

    //asignar un color a cada categoría 
    switch (category) {
      case 'COMIDA':
        return Colors.red;
      case 'VIAJE':
        return Colors.blue;
      case 'DIVIS':
        return Colors.green;
      case 'TRABAJO':
        return Colors.orange;
      default:
        return colors[index % colors.length];
    }
  }
}