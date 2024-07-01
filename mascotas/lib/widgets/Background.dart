import 'package:flutter/material.dart';
class Background extends StatelessWidget {

  final List<Color> colores;
  const Background({
    super.key,
    this.colores = const[
      Colors.transparent,
      Color.fromARGB(255, 57, 156, 254),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colores,
            //Posición
            stops: [0.6,1.0],
            //Se pone donde se inicia y donde termina el gradiente
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}