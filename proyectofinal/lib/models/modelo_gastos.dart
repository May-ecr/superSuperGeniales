class Gasto {
  final String titulo;
  final double cantidad;
  final String categoria;
  final DateTime fecha;
  final String id; // Opcional, para identificar gastos únicos

  Gasto({
    required this.titulo,
    required this.cantidad,
    required this.categoria,
    required this.fecha,
    String? id,
  }) : id = id ?? DateTime.now().toString(); // ID único si no se proporciona
}