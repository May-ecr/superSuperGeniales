class Gasto {//datos que debe llevar un gasto 
  final String titulo;
  final double cantidad;
  final String categoria;
  final DateTime fecha;

  Gasto({//indicamos que todos los campos deben estar llenos 
    required this.titulo,
    required this.cantidad,
    required this.categoria,
    required this.fecha,
  });

  //formato para mostrar los datos 
  String toDisplayString() {
    return "$titulo - \$${cantidad.toStringAsFixed(2)} - ${fecha.day}/${fecha.month}/${fecha.year}";
  }
}