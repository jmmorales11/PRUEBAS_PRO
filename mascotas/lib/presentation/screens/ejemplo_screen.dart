import 'package:flutter/material.dart';

class EjemploScreen extends StatefulWidget {
  const EjemploScreen({super.key});

  @override
  State<EjemploScreen> createState() => _EjemploScreenState();
}

class _EjemploScreenState extends State<EjemploScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            radius: 3.5,
            colors: [
              const Color.fromARGB(240, 22, 61, 96),
              const Color.fromARGB(255, 25, 23, 61),
              const Color.fromARGB(255, 25, 23, 61),
              const Color.fromARGB(255, 25, 23, 61),
              const Color.fromARGB(240, 25, 23, 61),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                children: [Text("Ejmplo Screen")],
              )
            ],
          ),
        ),
      )),
    );
  }
}
