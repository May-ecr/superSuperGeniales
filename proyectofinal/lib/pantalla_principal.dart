import 'package:flutter/material.dart';
import 'package:proyectofinal/models/modelo_gastos.dart'; 
import 'cuestionario.dart';
import 'package:proyectofinal/pantalla_grafica.dart';

class pantallaPrincipal extends StatefulWidget{
  const pantallaPrincipal({super.key});

  @override
  State<pantallaPrincipal> createState(){
  return  _pantallaPrincipalState();
  //  el StatefulWidget es una cosa que tiene dos partes, el estado y un
  //  widget(no entiendo que es el widget jaja) entonces en el estado 
  //  es donde se ponen o donde van las cosas que cambian
  }
}



//fin hann 


class _pantallaPrincipalState extends State<pantallaPrincipal>{
  //esta clase guarda todo lo que puede cambiar en nuestra bella pantalla 
  //final List<Gasto> _gastos = [];//para guardar los gastos, el _ significa que es privada la variable

  final List<Gasto> _gastos = [];

  @override
  Widget build(BuildContext context) {
    // el método build es lit construir, flutter ejecuta lo que pongamos
    //aquí cada vez que la pantalla se actualice o refresque como cuando 
    //agreguemos un gasto se tiene que volver a construir para mostrar el
    //nuevo gasto
    return Scaffold(
    backgroundColor: Colors.blue.shade100,//este es como una estructura para que la pantalla 
    //se vea linda, me imagino como el body en web 
    //dentro de aqui podemos poner los demas elementos que iran en nuestra bella pantalla
    appBar: AppBar(//appBar es como un espacio para una barra en la parte 
    //de arriba de la pantalla
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
      ) ,
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple.shade200,
      actions: [//botoncito para ver la grafica 
        IconButton(
          icon: const Icon(Icons.pie_chart),
          onPressed: _mostrarGrafica,
        ),
      ],
    ),
    body: _gastos.isEmpty ? const Center(//este es como el contenido principal de nuestra pantalla
      //y con center, centrará todo lo que esté adentro
      //child: Text ("aqui irá todo el merequetengue"),
      // el child es como un bebé, o sea por ejemplo el body es una caja
      // que es el papá, entonces child es una caja bebé dentro de la caja pantallaPrincipal
      // y cuando es child es pq en esta cajita solo habr´ra un elemento y 
      // cuando es children es que en esa caja puede haber más elementos que solo 1
      child: Text("No hay gastos."),
    )
    : ListView.builder(//crea una lista automatica
      itemCount: _gastos.length,//cuenta los elemetos
      itemBuilder: (context,index){//se ejecuta una vez por elemento
      final gasto = _gastos[index];
        return Card(//pone la lista linda
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        elevation: 2,
        
        child: ListTile(
        leading: Text( // agregamos iconos
          _getEmojiForCategory(gasto.categoria),
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(gasto.titulo),
        subtitle: Text(
          "${gasto.categoria}, ${gasto.fecha.day}/${gasto.fecha.month}/${gasto.fecha.year}",
        ),
        trailing: Text(
          "\$${gasto.cantidad.toStringAsFixed(2)}",

        ),
        ),
        );
        },
        ),

    floatingActionButton: FloatingActionButton(
      // floatingActionButton es un bontoncito flotante y redondito
      onPressed: () async {//aqui ponemos lo que pasa cuando lo presionamos
        // Navigator.of(context).push(//aqui ya le decimos al boton lo que queremos que haga
        // //que sería cambiar a la pantalla del fomulario
        //   MaterialPageRoute(
        //     builder: (context) => const Cuestionario(),
        //     ),
        // );async es que espera un valor
        final nuevoGasto = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Cuestionario()),
        );

        if (nuevoGasto != null){
        if (nuevoGasto != null && nuevoGasto is Gasto){
          _agregarGasto(nuevoGasto);
        }
        }
      },
      
      child: const Icon(Icons.add),//con icons icon.add le decimos q adentro
      //del boton ira el icono + 
    ),
    );
  }  

  void _agregarGasto(Gasto nuevoGasto) {//para que la pantalla se reconstruya
  //para que la pantalla se reconstruya
  //cada vex que agreguemos algo nuevo 
    setState((){
      _gastos.add(nuevoGasto);//agrega los gastos
    });
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
