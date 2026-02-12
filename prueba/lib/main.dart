
import 'package:flutter/material.dart';

void main() {
  runApp(const ControlGastosApp());
}

class ControlGastosApp extends StatelessWidget {
  const ControlGastosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Gastos Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GastosScreen(),
    );
  }
}

class GastosScreen extends StatelessWidget {
  const GastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gastos = [
      {"titulo": "Curso Dart", "monto": 199.90, "icono": Icons.book, "fecha": "2/10/2026"},
      {"titulo": "Cine", "monto": 200.00, "icono": Icons.movie, "fecha": "2/10/2026"},
      {"titulo": "Mi Viaje", "monto": 234.00, "icono": Icons.flight, "fecha": "2/3/2026"},
      {"titulo": "Buffet", "monto": 258.00, "icono": Icons.fastfood, "fecha": "2/5/2026"},
      {"titulo": "Viaje Nuevo", "monto": 10000.00, "icono": Icons.flight, "fecha": "2/2/2026"},
      {"titulo": "Comida", "monto": 7000.00, "icono": Icons.fastfood, "fecha": "2/2/2026"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Control Gastos Flutter")),
      body: Column(
        children: [
          // Sección de gráficos (placeholder por ahora)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.book, size: 40),
                Icon(Icons.movie, size: 40),
                Icon(Icons.flight, size: 40),
                Icon(Icons.work, size: 40),
              ],
            ),
          ),
          // Lista de gastos
          Expanded(
            child: ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                final gasto = gastos[index];
                return ListTile(
                  leading: Icon(gasto["icono"] as IconData),
                  title: Text(gasto["titulo"] as String),
                  subtitle: Text(gasto["fecha"] as String),
                  trailing: Text("\$${gasto["monto"]}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}